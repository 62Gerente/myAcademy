require 'nokogiri'

module Parser
  class ThesisSupervision
    def initialize
      @document = Nokogiri::XML File.open(Rails.root.join('lib', 'parsers', 'data-sets', 'thesup.xml').to_s)
      @root = @document.root.xpath('the')
      @cosupervisors = []
      @supervisions = []
    end

    def xml
      @document.to_xml
    end

    def supervisions
      parse_supervisions if @supervisions.empty?
      @supervisions
    end

    def cosupervisors
      parse_supervisions if @cosupervisors.empty?
      @cosupervisors
    end

    @private

    def parse_supervisions
      @root.each do |node|
        supervision = get_supervision(node)
        supervisions = get_supervisions(supervision,node)
        @supervisions << supervisions
        parse_cosupervisor(node)
      end
    end

    def parse_cosupervisor(node)
      if node.at_xpath('cosup')
        cosupervisor = get_cosupervisor(node)
        @cosupervisors << cosupervisor
      end
    end

    def get_cosupervisor(node)
      supervisor = {}
      supervisor["name"] = node.at_xpath('cosup/name').text
      supervisor["institution"] = node.at_xpath('cosup/inst').text
      supervisor
    end

    def get_supervision(node)
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

    def get_supervisions(thesis,node)
      supervisions = {}
      supervisions["thesis_id"] = Thesis.where(thesis).first_or_create!.id
      begin_date = node.at_xpath("begin_date")
      supervisions["begin_date"] = Date.parse(begin_date.text) if begin_date 
      end_date = node.at_xpath("begin_date")
      supervisions["end_date"] = Date.parse(end_date.text) if end_date
      supervisions["teacher_id"] = 1
      supervisions
    end
  end
end
