require 'nokogiri'

module Parser
  class ThesisExamination
    def initialize
      @document = Nokogiri::XML File.open(Rails.root.join('lib', 'parsers', 'data-sets', 'the-exams.xml').to_s)
    end

    def xml
      @document.to_xml
    end

    def get_examinations
      doc = all.root.xpath('theexam')
      theses = []
      doc.each do |node|
        thesis = get_thesis(node)
        thesis_examination = get_thesis_examination(thesis,node)
        theses << thesis_examination
      end
      theses
    end

    def all
      @document
    end

    @private

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

    def get_thesis_examination(thesis,node)
      thesis_examination = {}
      thesis_examination["thesis_id"]=Thesis.where(thesis).first_or_create!.id
      date = node.at_xpath("date/@ansi | date").text
      thesis_examination["date"]=Date.parse(date)
      thesis_examination["teacher_id"]=1
      thesis_examination
    end
  end


end
