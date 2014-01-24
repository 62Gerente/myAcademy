require 'nokogiri'

module Seeder
  class ThesisSupervisions
    def initialize
      @document = Nokogiri::XML File.open(Rails.root.join('lib', 'seeder', 'data-sets', 'thesup.xml').to_s)
      @thesups = @document.root.xpath('the')
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
      parse_supervisions if @supervisions.empty?
      @cosupervisors
    end

    def seed
      parse_supervisions if @supervisions.empty?
      seed_supervisions
      seed_cosupervisors
    end

    def seed_supervisions
      @supervisions.each do |supervision|
        create_and_get_supervision(supervision)
      end
    end

    def seed_cosupervisors
      @cosupervisors.each do |cosupervisor|
        Cosupervisor.where(cosupervisor).first_or_create!
      end
    end

    @private

    def parse_supervisions
      @thesups.each do |node|
        supervision = get_supervision(node)
        supervisions = get_supervisions(supervision,node)
        @supervisions << supervisions
        parse_cosupervisor(node, supervisions)
      end
    end

    def parse_cosupervisor(node, supervision)
      if node.at_xpath('cosup')
        cosupervisor = get_cosupervisor(node, supervision)
        @cosupervisors << cosupervisor
      end
    end

    def get_cosupervisor(node, supervision)
      cosupervisor = {}
      cosupervisor["name"] = node.at_xpath('cosup/name').text
      cosupervisor["institution"] = node.at_xpath('cosup/inst').text
      cosupervisor["thesis_supervision_id"] = create_and_get_supervision(supervision).id
      cosupervisor
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

    def create_and_get_supervision(supervision)
      begin_date = supervision.delete("begin_date")
      end_date = supervision.delete("end_date")
      tsupervision = ThesisSupervision.where(supervision).first_or_create!
      ThesisSupervision.update(tsupervision.id, begin_date: begin_date) if begin_date
      ThesisSupervision.update(tsupervision.id, end_date: end_date) if end_date
      tsupervision
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

    def get_supervisions(thesis,node)
      supervisions = {}
      supervisions["thesis_id"] = get_thesis(thesis).id
      begin_date = node.at_xpath("begin_date")
      supervisions["begin_date"] = Date.parse(begin_date.text) if begin_date 
      end_date = node.at_xpath("begin_date")
      supervisions["end_date"] = Date.parse(end_date.text) if end_date
      supervisions["teacher_id"] = 1
      supervisions
    end
  end
end
