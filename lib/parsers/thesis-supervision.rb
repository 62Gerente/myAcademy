require 'nokogiri'

module Parser
  class ThesisSupervision
    def initialize
      @document = Nokogiri::XML File.open(Rails.root.join('lib', 'parsers', 'data-sets', 'thesup.xml').to_s)
    end

    def xml
      @document.to_xml
    end

    def get_supervisions
      doc = @document.root.xpath('the')
      theses = []
      doc.each do |node|
        thesis = get_thesis(node)
        thesis_supervisions = get_thesis_supervisions(thesis,node)
        theses << thesis_supervisions
      end
      theses
    end

    @private

    def get_thesis(node)
      thesis = {}
      thesis["title"] = node.at_xpath('document/title').text
      thesis["student"] = node.at_xpath('student/name').text
      url = node.at_xpath('document/doi')
      thesis["url"] = url.text if url
      institution = node.at_xpath('inst').text
      thesis["institution_id"] = get_institution(institution).id
      academic_degree = node.at_xpath('@type').text
      thesis["academic_degree_id"]= get_academic_degree(academic_degree).id
      thesis
    end

    def get_institution(name)
      Institution.where(name: name).first_or_create!
    end

    def get_academic_degree(degree)
      AcademicDegree.where(name: degree).first
    end

    def get_thesis_supervisions(thesis,node)
      thesis_supervisions = {}
      thesis_supervisions["thesis_id"]=Thesis.where(thesis).first_or_create!.id
      begin_date = node.at_xpath("begin_date").text
      thesis_supervisions["begin_date"]=Date.parse(begin_date)
      end_date = node.at_xpath("begin_date")
      thesis_supervisions["end_date"]=Date.parse(end_date.text) if end_date
      thesis_supervisions["teacher_id"]=1
      thesis_supervisions
    end
  end
end
