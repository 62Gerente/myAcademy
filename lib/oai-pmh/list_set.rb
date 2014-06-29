require 'nokogiri'
require 'oai-pmh/exception.rb'
require 'securerandom'
module OaiPmh
  class ListSet
    def initialize(options)
      @xmlns = "http://www.openarchives.org/OAI/2.0/"
      @xmlns_xsi="http://www.w3.org/2001/XMLSchema-instance"
      @xsi_schemaLocation="http://www.openarchives.org/OAI/2.0/ http://www.openarchives.org/OAI/2.0/OAI-PMH.xsd"
      @request=options[:request]
      @resumptionToken=options[:resumptionToken]
      @response=Time.now.utc.iso8601
      @pageSize = 100
      @page = 1
      @cursor = 0
    end

    def xml
      @oai_request = OaiPmhRequest.where(resumption_code: @resumptionToken).first if @resumptionToken
      @cursor = @oai_request.cursor+@pageSize if @oai_request

      if(@oai_request || !@resumptionToken)
        if(@oai_request && @oai_request.verb != "ListSets")
          exception = OaiPmh::Exception.new(request: @request, resumptionToken: @resumptionToken, verb: "ListSets", code: "badResumptionToken", message: "This resumptionToken (#{@resumptionToken}) is not valid. Resumption tokens are not issued for ListIdentifiers from this repository." )
          return exception.xml
        end
        build = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
          xml.send(:"OAI-PMH",'xmlns'=> @xmlns,'xmlns:xsi'=>@xmlns_xsi,'xsi:schemaLocation'=>@xsi_schemaLocation){
            addResponseDate(xml)
            addRequest(xml)
            addListSets(xml)
          }
        end
        entry = OaiPmhRequest.new(resumption_code: @resumptionToken, verb: "ListSet", cursor: @cursor)
        entry.save if @resumptionToken
        build.to_xml
      else
        exception = OaiPmh::Exception.new(request: @request, verb: "ListSets", resumptionToken: @resumptionToken, code: "badResumptionToken", message: "This resumptionToken (#{@resumptionToken}) is not valid. Resumption tokens are not issued for ListSets from this repository.")
        exception.xml
      end
    end
    private
    def addResponseDate(xml)
      xml.responseDate @response
    end

    def addRequest(xml)
      args = {}
      args["value"] = "ListSets"
      args["resumptionToken"] = @resumptionToken if @resumptionToken
      xml.request(args){xml.text "#{@request}/oai"}
    end


    def addListSets(xml)
      @page = @oai_request.cursor/@pageSize + 2 if @oai_request
      xml.ListSets{
        addPublicationSet(xml)
        PublicationType.paginate(page: @page, per_page: @pageSize).each do |pt|
          addPublicationTypeSet(xml,pt.name)
        end
        addResumptionToken(xml)
      }
    end

    def addPublicationSet(xml)
      xml.set{
        xml.setSpec "publication"
        xml.setName "Publications"
      }
    end

    def addPublicationTypeSet(xml,name)
      xml.set{
        xml.setSpec "publication: (#{name})"
        xml.setName "#{name.capitalize} Publication"
      }
    end

    def addResumptionToken(xml)
      resumptionToken = SecureRandom.hex
      if(PublicationType.paginate(page: @page+1, per_page: @pageSize).first)
        xml.resumptionToken(completeListSize: PublicationType.all.size, cursor: @cursor){
          xml.text resumptionToken
        }
        @resumptionToken = resumptionToken
      else
        @resumptionToken = nil
      end
    end
  end
end
