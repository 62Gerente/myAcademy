require 'nokogiri'

module Parser
  class ThesisExamination
    def initialize
      @document = Nokogiri::XML File.open(Rails.root.join('lib', 'parsers', 'data-sets', 'the-exams.xml').to_s)
      @theexams = @document.root.xpath('theexam')
      @examinations = []
    end

    def xml
      @document.to_xml
    end

    def examinations
      parse_examinations if @examinations.empty?
      @examinations
    end

    @private

    def parse_examinations
      @theexams.each do |node|
        thesis = get_thesis(node)
        examination = get_examination(thesis,node)
        @examinations << examination
      end
    end

    def get_thesis(node)
      thesis = {}
      thesis["title"] = node.at_xpath('document/title').text
      thesis["student"] = node.at_xpath('student/name').text
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

    def get_thesis(thesis)
      Thesis.where(thesis).first_or_create!
    end

    def get_examination(thesis,node)
      examination = {}
      examination["thesis_id"] = get_thesis(thesis).id
      date = node.at_xpath("date/@ansi | date").text
      examination["date"] = Date.parse(date)
      examination["teacher_id"] = 1
      examination
    end
  end
end
