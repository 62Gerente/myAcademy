require 'nokogiri'

module OaiPmh
  class GetRecord
    def initialize(options)
      @xmlns = "http://www.openarchives.org/OAI/2.0/"
      @xmlns_xsi="http://www.w3.org/2001/XMLSchema-instance"
      @xsi_schemaLocation="http://www.openarchives.org/OAI/2.0/ http://www.openarchives.org/OAI/2.0/OAI-PMH.xsd"
      @request=options[:request]
      @response=Time.now.utc.iso8601
      @identifier = options[:identifier]
      @metadataPrefix = options[:metadataPrefix]
      @valid = validaIdentifier
    end

    def xml
      build = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
        xml.send(:"OAI-PMH",'xmlns'=> @xmlns,'xmlns:xsi'=>@xmlns_xsi,'xsi:schemaLocation'=>@xsi_schemaLocation){
          addResponseDate(xml)
          addRequest(xml)
          addGetRecord(xml)
        }
      end
      build.to_xml
    end

    private
    def validaIdentifier
      regex = /\A(oai):(?<REQUEST>#{URI.regexp}):(?<ID>\d+)\z/
      if(regex.match(@identifier))
        @publication = Publication.where(id: regex.match(@identifier)["ID"]).first
        return true if @publication
      end
      false
    end
    def addResponseDate(xml)
      xml.responseDate @response
    end

    def addRequest(xml)
      xml.request(value: "GetRecord", metadataPrefix: @metadataPrefix, identifier: @identifier){xml.text "#{@request}/oai"}
    end
    def addGetRecord(xml)
      xml.GetRecord{
        addRecord(xml)
      }
    end
    def addRecord(xml)
      xml.record{
        addHeader(xml)
        addMetaData(xml)
      }
    end
    def addHeader(xml)
      xml.header{
        xml.identifier @identifier
        xml.datestamp @publication.date.strftime("%Y/%m/%d")
        xml.setSpec "Publication"
        xml.setSpec @publication.publication_type.name
      }
    end
    def addMetaData(xml)
      xml.metadata{
        xml.send(:"oai_dc:dc",
                  "xmlns:oai_dc"=>"http://www.openarchives.org/OAI/2.0/oai_dc/",
                  "xmlns:dc"=>"http://purl.org/dc/elements/1.1/",
                  "xmlns:xsi"=>"http://www.w3.org/2001/XMLSchema-instance",
                  "xsi:schemaLocation"=>"http://www.openarchives.org/OAI/2.0/oai_dc/ http://www.openarchives.org/OAI/2.0/oai_dc.xsd"
                ){
          addPublicationInfo(xml)
        }
      }
    end

    def addPublicationInfo(xml)
      xml.send(:"dc:title"){xml.text @publication.title}
      xml.send(:"dc:creator"){xml.text @publication.teacher.name}
      xml.send(:"dc:identifier"){xml.text @publication.uri} if @publication.uri
    end
  end
end
