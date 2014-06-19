require 'nokogiri'

module OaiPmh
  class ListSet
    def initialize(request)
      @xmlns = "http://www.openarchives.org/OAI/2.0/"
      @xmlns_xsi="http://www.w3.org/2001/XMLSchema-instance"
      @xsi_schemaLocation="http://www.openarchives.org/OAI/2.0/ http://www.openarchives.org/OAI/2.0/OAI-PMH.xsd"
      @request=request
      @response=Time.now.utc.iso8601
    end

    def xml
      build = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
        xml.send(:"OAI-PMH",'xmlns'=> @xmlns,'xmlns:xsi'=>@xmlns_xsi,'xsi:schemaLocation'=>@xsi_schemaLocation){
          addResponseDate(xml)
          addRequest(xml)
          addListSets(xml)
        }
      end
      build.to_xml
    end
    private
    def addResponseDate(xml)
      xml.responseDate @response
    end

    def addRequest(xml)
      xml.request(value: "ListSets"){xml.text @request}
    end


    def addListSets(xml)

      xml.ListSets{
        addPublicationSet(xml)
        PublicationType.all.each do |pt|
          addPublicationTypeSet(xml,pt.name)
        end
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
  end
end
