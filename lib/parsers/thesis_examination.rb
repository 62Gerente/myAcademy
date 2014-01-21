require 'nokogiri'

module Parser
  class ThesisExamination
    def initialize
      @document = Nokogiri::XML File.open(Rails.root.join('lib', 'parsers', 'data-sets', 'the-exams.xml').to_s)
    end

    def xml
      @document.to_xml
    end

    def all 
      @document
    end

    @private

  end
end
