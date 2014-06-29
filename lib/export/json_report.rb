module Export
  class JsonReport
    def initialize(id)
      @json = {}
      @teacher = Teacher.find(id)
    end

    def json
      addSettings
      addName
      addBio
      @json.to_json
    end

    def pdf
      saveJson
      json_file = Rails.root.join('public/system/export',"#{@teacher.id}.json")
      json_pdf = Rails.root.join("resume.pdf")
      json_dest = Rails.root.join('public/system/export',"#{@teacher.id}.pdf")
      `echo -e "n\n" | json_resume convert --out=tex_pdf #{json_file}`
      `mv #{json_pdf} #{json_dest}`
    end

    def md
      saveJson
      json_file = Rails.root.join('public/system/export',"#{@teacher.id}.json")
      json_md = Rails.root.join("resume.md")
      json_dest = Rails.root.join('public/system/export',"#{@teacher.id}.md")
      `echo -e "n\n" | json_resume convert --out=md #{json_file}`
      `mv #{json_md} #{json_dest}`
    end

    private
    def saveJson
      File.open(Rails.root.join('public/system/export',"#{@teacher.id}.json"), 'wb') { |file| file.write(json) }
    end
    def addSettings
      @json[:settings] = {
        glyphicons: true
      }
    end

    def addName
      @json[:firstname] = @teacher.name
    end

    def addBio
      @json[:bio_data] = {}
      addEmail
      addPhone
      addWebSite
      addEducation
      addExperience
      addResearchProject
      addPapers
    end

    def addEmail
      @json[:bio_data][:email] =  @teacher.email
    end

    def addPhone
      @json[:bio_data][:phone] = @teacher.phone
    end

    def addWebSite
      @json[:bio_data][:website] = @teacher.url
    end

    def addEducation
      @json[:education] = {show_gpa: true, schools: []}
      @teacher.academic_informations.each do |ai|
        info = {}
        info[:degree] = ai.academic_degree.name
        info[:major] = ai.course.name
        info[:institution] = ai.institution.name
        info[:graduation_year] = ai.e_date.year
        @json[:education][:schools] << info
      end
    end

    def addExperience
      @json[:experience] = {items: []}
      @teacher.subjects.each do |s|
        item = {}
        date_pattern = /\A(?<BEGIN>\d+)\/(?<END>\d+)\z/
        item[:from] = date_pattern.match(s.academic_year)["BEGIN"]
        item[:to] = date_pattern.match(s.academic_year)["END"]
        item[:details] = []
        item[:details] << s.description if s.description
        @json[:experience][:items] << item
      end
    end

    def addResearchProject
      @json[:research_experience] = {items: []}
      @teacher.research_projects.each do |rp|
        item = {}
        item[:item] = rp.name
        item[:from] = rp.b_date.year
        if rp.e_date
          item[:to] = rp.e_date.strftime "%b %Y"
        else
          item[:to] = "Current"
        end
        item[:points] = []
        item[:points] << rp.description if rp.description
        @json[:research_projects][:items] << item
      end
    end

    def addPapers
      @json[:papers] = {items: []}
      @teacher.publications.sort_by{|p|p.date}.each do |p|
        item = {}
        item[:title] = p.title
        item[:misc] = "#{p.publication_type.name} | #{p.date.strftime "%b %Y"}"
      @json[:papers][:items] << item
      end
    end
  end
end
