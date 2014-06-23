require 'nokogiri'

module OaiPmh
  class ListIdentifiers
    def initialize(options)
      @xmlns = "http://www.openarchives.org/OAI/2.0/"
      @xmlns_xsi="http://www.w3.org/2001/XMLSchema-instance"
      @xsi_schemaLocation="http://www.openarchives.org/OAI/2.0/ http://www.openarchives.org/OAI/2.0/OAI-PMH.xsd"
      @request=options[:request]
      @response=Time.now.utc.iso8601
    end

    def xml
      build = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
        xml.send(:"OAI-PMH",'xmlns'=> @xmlns,'xmlns:xsi'=>@xmlns_xsi,'xsi:schemaLocation'=>@xsi_schemaLocation){
          addResponseDate(xml)
          addRequest(xml)
          addListIdentifiers(xml)
        }
      end
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
      xml.ListIdentifiers{
        Publication.all.each do |p|
          addHeader(xml,p)
        end
      }
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
