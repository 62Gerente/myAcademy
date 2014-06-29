require 'nokogiri'
require 'oai-pmh/exception.rb'
require 'securerandom'

module OaiPmh
  class ListIdentifiers
    def initialize(options)
      @xmlns = "http://www.openarchives.org/OAI/2.0/"
      @xmlns_xsi="http://www.w3.org/2001/XMLSchema-instance"
      @xsi_schemaLocation="http://www.openarchives.org/OAI/2.0/ http://www.openarchives.org/OAI/2.0/OAI-PMH.xsd"
      @request=options[:request]
      @response=Time.now.utc.iso8601
      @from = options[:from]
      @until = options[:until]
      @metadataPrefix = options[:metadataPrefix]
      @resumptionToken = options[:resumptionToken]
      @set = options[:set]
      @pageSize = 100
      @page = 1
      @cursor = 0
    end

    def xml
      if(@resumptionToken)
        if(@metadataPrefix)
          exception = OaiPmh::Exception.new(request: @request, metadataPrefix: @metadataPrefix, verb: "ListIdentifiers", resumptionToken: @resumptionToken, code: "badArgument", message: "An argument (\"metadataPrefix\") was passed that was not valid for this verb")
          return exception.xml
        end
        oai_request = OaiPmhRequest.where(resumption_code: @resumptionToken).first
        if(!oai_request)
          exception = OaiPmh::Exception.new(request: @request, verb: "ListIdentifiers", code: "badResumptionToken", message: "This resumptionToken (#{@resumptionToken}) is invalid or expired")
          return exception.xml
        end
        if(oai_request.verb != "ListIdentifiers")
          exception = OaiPmh::Exception.new(request: @request, resumptionToken: @resumptionToken, verb: "ListIdentifiers", code: "badResumptionToken", message: "This resumptionToken (#{@resumptionToken}) is not valid. Resumption tokens are not issued for ListIdentifiers from this repository." )
          return exception.xml
        end
        @cursor = oai_request.cursor+@pageSize
        @page = oai_request.cursor/@pageSize + 2
      else
        if (!@metadataPrefix)
          exception = OaiPmh::Exception.new(request: @request, verb: "ListIdentifiers", code: "badArgument", message: "Missing required argument (metadataPrefix).")
          return exception.xml
        end
      end

      build = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
        xml.send(:"OAI-PMH",'xmlns'=> @xmlns,'xmlns:xsi'=>@xmlns_xsi,'xsi:schemaLocation'=>@xsi_schemaLocation){
          addResponseDate(xml)
          addRequest(xml)
          addListIdentifiers(xml)
        }
      end
      entry = OaiPmhRequest.new(resumption_code: @resumptionToken, verb: "ListIdentifiers", cursor: @cursor)
      entry.save if @resumptionToken
      build.to_xml
    end

    private
    def addResponseDate(xml)
      xml.responseDate @response
    end

    def addRequest(xml)
      xml.request(value: "ListIdentifiers"){xml.text @request}
    end

    def addListIdentifiers(xml)
      if @set
        @publications = PublicationType.where(name: @set).first.publications
      else
        @publications = Publication.all
      end
      xml.ListIdentifiers{
        @publications.paginate(page: @page, per_page: @pageSize).all.each do |p|
          addHeader(xml,p)
        end
        addResumptionToken(xml)
      }
    end

    def addResumptionToken(xml)
      resumptionToken = SecureRandom.hex
      if(@publications.paginate(page: @page+1, per_page: @pageSize).first)
        xml.resumptionToken(completeListSize: PublicationType.all.size, cursor: @cursor){
          xml.text resumptionToken
        }
        @resumptionToken = resumptionToken
      else
        @resumptionToken = nil
      end
    end

    def addHeader(xml,publication)
      url = URI.split(@request)[2]
      url+=":"+ URI.split(@request)[3] if URI.split(@request)[3]

      xml.header{
        xml.identifier "oai:#{url}:#{publication.id}"
        xml.datestamp publication.date.strftime("%Y/%m/%d")
        xml.setSpec "publication:#{publication.publication_type.name}"
      }
    end
  end
end
