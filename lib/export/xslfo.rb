require 'nokogiri'

module Export
  class XSLFO
    def initialize(id)
      @teacher = Teacher.find(id)
    end

    def xml
      build = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
        xml.teacher{
          add_basic_info xml
          add_academic_info xml
          add_hobbies xml
          add_research_projects xml
          add_publications xml
          add_supervisions xml
          add_examinations xml
        }
      end
      build.to_xml
    end

    def save
      File.open(Rails.root.join('public','teste.pdf'), 'wb') { |file| file.write(pdf) }
    end

    private

    def add_basic_info xml
      xml.basic_info{
        xml.name @teacher.name
        xml.bio @teacher.bio
        xml.status @teacher.status
        xml.email @teacher.email
        xml.username @teacher.name
        xml.phone @teacher.phone
        l = nil
        xml.birthday @teacher.birthday.strftime("%B %d, %Y") if @teacher.birthday
        xml.institution @teacher.institution.name
        xml.url @teacher.url
        xml.photo "http://0.0.0.0:3000"+@teacher.photo.url
      }
    end

    def add_academic_info xml
      xml.academic_info{
        @teacher.academic_informations.each do |c|
          xml.course{
            xml.course_name c.course.name
            xml.academic_degree c.academic_degree.name
            xml.institution c.institution.name
            xml.b_date try_date_format_year(c.b_date)
            xml.e_date try_date_format_year(c.b_date)
          }
        end
      }
    end

    def add_hobbies xml
      xml.hobbies{
        @teacher.hobbies.each do |h|
          xml.hobbie{
            xml.activity h.activity
            xml.description h.description
          }
        end
      }
    end

    def add_research_projects xml
      xml.research_projects{
        @teacher.research_projects.each do |p|
          xml.project{
            xml.name p.name
            xml.description p.description
            xml.b_date try_date_format_year(p.b_date)
            xml.e_date try_date_format_year(p.b_date)
            xml.url p.url
          }
        end
      }
    end

    def add_publications xml
      xml.publications{
        @teacher.publications.each do |p|
          xml.publication{
            xml.type p.publication_type.name
            xml.title p.title
            xml.publisher p.publisher
            xml.chapter p.chapter
            xml.address p.address
            xml.pages p.pages
            xml.volume p.volume
            xml.isbn p.isbn
            xml.issn p.issn
            xml.booktitle p.booktitle
            xml.journal p.journal
            xml.number p.number
            xml.published p.howpublished
            xml.school p.school
            xml.uri p.uri
            xml.authors{
              p.authors.each do |a|
                xml.author a.name
              end
            }
          }
        end
      }
    end

    def add_supervisions xml
      xml.thesis_supervisions{
        @teacher.thesis_supervisions.each do |s|
          xml.supervision{
            xml.b_date try_date_format_year s.b_date
            xml.e_date try_date_format_year s.e_date
            xml.title s.thesis.title
            xml.student s.thesis.student
            xml.academic_degree s.academic_degree.name
            xml.institution s.institution.name
          }
        end
      }
    end

    def add_examinations xml
      xml.thesis_examinations{
        @teacher.thesis_examinations.each do |e|
          xml.examination{
            xml.date e.date.strftime("%B %d, %Y") if e.date
            xml.title e.thesis.title
            xml.student e.thesis.student
            xml.academic_degree e.academic_degree.name
            xml.institution e.institution.name
          }
        end
      }
    end

    def add_teaching xml
      xml.teaching{
        @teacher.subjects.each do |s|
          xml.subject{
            xml.name s.name
            xml.academic_year s.academic_year
            xml.course s.course.name
            xml.institution s.course.institution.name
          }
        end
      }
    end

    def try_date_format_year date
      if date
        date.strftime("%Y")
      else
        "?"
      end
    end

  end
end
