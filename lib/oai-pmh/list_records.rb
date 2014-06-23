require 'nokogiri'

module OaiPmh
  class ListRecords
    def initialize(options)
      @xmlns = "http://www.openarchives.org/OAI/2.0/"
      @xmlns_xsi="http://www.w3.org/2001/XMLSchema-instance"
      @xsi_schemaLocation="http://www.openarchives.org/OAI/2.0/ http://www.openarchives.org/OAI/2.0/OAI-PMH.xsd"
      @request=options[:request]
      @response=Time.now.utc.iso8601
      @from = options[:from]
      @until = options[:until]
      @set = options[:set]
      @resumptionToken = options[:resumptionToken]
      @metadataPrefix = options[:metadataPrefix]
    end

    def xml
      build = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
        xml.send(:"OAI-PMH",'xmlns'=> @xmlns,'xmlns:xsi'=>@xmlns_xsi,'xsi:schemaLocation'=>@xsi_schemaLocation){
          addResponseDate(xml)
          addRequest(xml)
          addListRecords(xml)
        }
      end
      build.to_xml
    end

    private
    def addResponseDate(xml)
      xml.responseDate @response
    end

    def addRequest(xml)
      args = {}
      args["value"] = "ListRecords"
      args["metadataPrefix"] = @metadataPrefix
      args["resumptionToken"] = @resumptionToken if @resumptionToken
      args["set"] = @set if @set
      args["from"] = @from if @from
      args["until"] = @until if @until
      xml.request(args){xml.text @request}
    end

    def addListRecords(xml)
      xml.ListRecords{
        Publication.all.each do |p|
          addRecord(xml,p)
        end
      }
    end

    def addRecord(xml,publication)
      url = URI.split(@request)[2]
      url+=":"+ URI.split(@request)[3] if URI.split(@request)[3]
      xml.record{
        addHeader(xml,publication,url)
        addMetaData(xml,publication)
      }
    end

    def addHeader(xml,publication,url)
      xml.header{
        xml.identifier "oai:#{url}:#{publication.id}"
        xml.datestamp publication.date.strftime("%Y/%m/%d")
        xml.setSpec "publication:#{publication.publication_type.name}"
      }
    end

    def addMetaData(xml,publication)
      xml.metadata{
        xml.send(:"oai_dc:dc",
                 "xmlns:oai_dc"=>"http://www.openarchives.org/OAI/2.0/oai_dc/",
                 "xmlns:dc"=>"http://purl.org/dc/elements/1.1/",
                 "xmlns:xsi"=>"http://www.w3.org/2001/XMLSchema-instance",
                 "xsi:schemaLocation"=>"http://www.openarchives.org/OAI/2.0/oai_dc/ http://www.openarchives.org/OAI/2.0/oai_dc.xsd"
        ){
          addPublicationInfo(xml,publication)
        }
      }
    end

    def addPublicationInfo(xml,publication)
      xml.send(:"dc:title"){xml.text publication.title}
      xml.send(:"dc:creator"){xml.text publication.teacher.name}
      xml.send(:"dc:identifier"){xml.text publication.uri} if publication.uri
    end
  end
end
