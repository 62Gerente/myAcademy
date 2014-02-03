require 'nokogiri'
require 'rest_client'
require 'base64'

module Export
	class Europass
		def initialize(id)
			@teacher = Teacher.find(id)
			@url = url = 'https://europass.cedefop.europa.eu/rest/v1/document/to/pdf-cv'
			@xmlns = "http://europass.cedefop.europa.eu/Europass"
			@xmlns_xsi = "http://www.w3.org/2001/XMLSchema-instance"
			@xsi_schemaLocation="http://europass.cedefop.europa.eu/Europass http://europass.cedefop.europa.eu/xml/EuropassSchema_V3.0.xsd"
			@locale = 'pt'

		end

		def xml
			build = Nokogiri::XML::Builder.new(encoding: 'UTF-8') do |xml|
				addSkillsPassport xml
			end
			build.to_xml
		end


		def pdf
			rest = RestClient.post @url, xml , :content_type => 'application/xml'
		end

		def save
			File.open(Rails.root.join('public','teste.pdf'), 'wb') { |file| file.write(pdf) }
		end

		private
		def addSkillsPassport(xml)
			xml.SkillsPassport('xmlns'=> @xmlns,'xmlns:xsi'=>@xmlns_xsi,'xsi:schemaLocation'=>@xsi_schemaLocation, 'locale' => @locale ){
				addDocumentInfo xml
				addLearnerInfo xml
			}
		end

		def addDocumentInfo(xml)
			xml.DocumentInfo{
				xml.DocumentType 'ECV'
				xml.CreationDate  DateTime.now.iso8601
				xml.LastUpdateDate DateTime.now.iso8601
				xml.XSDVersion 'V3.0'
				xml.Generator 'EWA'
			}
		end

		def addLearnerInfo(xml)
			xml.LearnerInfo{
				addIdentification xml
				addHeadline xml
				addWorkExperienceList xml
				addEducationList xml
				addSkills xml
				addAchievementList xml
			}
		end

		def addIdentification(xml)
			xml.Identification{
				addPersonName xml
				addContactInfo xml
				addDemographics xml
				addPhoto xml if @teacher.photo?
			}
		end

		def addPersonName(xml)
			xml.PersonName{
				xml.FirstName @teacher.name
			}
		end

		def addContactInfo(xml)
			xml.ContactInfo{
				addEmail xml
				addTelephoneList xml
				addWebsiteList xml
			}
		end

		def addEmail(xml)
			xml.Email{
				xml.Contact @teacher.email
			}
		end

		def addTelephoneList(xml)
			xml.TelephoneList{
				xml.Telephone{
					xml.Contact @teacher.phone
				}
			}
		end

		def addWebsiteList(xml)
			xml.WebsiteList{
				xml.Website{
					xml.Contact @teacher.url
				}
			}
		end

		def addDemographics(xml)
			xml.Demographics{
				addBirthdate xml
			}
		end

		def addBirthdate(xml)
			year = @teacher.birthday.year
			month = @teacher.birthday.strftime("--%m")
			day = @teacher.birthday.strftime("---%d")
			xml.Birthdate(year: year, month: month, day: day)
		end

		def addPhoto(xml)
			xml.Photo{
				xml.MimeType @teacher.photo_content_type
				xml.Data Base64.encode64(File.read(@teacher.photo.path))
			}
		end

		def addAchievementList(xml)
			xml.AchievementList{
				@teacher.publications.order(date: :desc).each do |publication|
					addPublication xml, publication
				end
			}
		end

		def addPublication(xml,publication)
			date = I18n.l publication.date , locale: @locale, format: "%b %Y"
			xml.Achievement{
				addAchievementTitle xml, "publications", date
				addDescription xml, "'#{publication.title}' #{publication.publisher}"
			}
		end

		def addAchievementTitle(xml,type,date)
			xml.Title{
				xml.Code date
				xml.Label date
			}
		end

		def addDescription(xml, description)
			xml.Description description
		end

		def addSkills(xml)
			xml.Skills{
				addOther xml
			}
		end

		def addOther(xml)
			xml.Other{
				xml.Description addHobbies
			}
		end

		def addHobbies
			hobbies = ""
			@teacher.hobbies.each do |hobby|
				hobbies+=", " unless hobbies == ""
				hobbies+=hobby.activity
			end
			hobbies
		end

		def addHeadline(xml)
			xml.Headline{
				xml.Type{
					xml.Code "status"
					xml.Label "Estado"
				}
				xml.Description{
					xml.Label @teacher.status
				}
			}
		end

		def addWorkExperienceList(xml)
			xml.WorkExperienceList{
				@teacher.managements.each do |management|
					addWorkExperience xml, management
				end
			}
		end

		def addWorkExperience(xml,management)
			year = management.b_date.year
			month = management.b_date.strftime("--%m")
			xml.WorkExperience{
				xml.Period{
					xml.From(year: year, month: month)
					if management.date
						xml.To(year: management.e_date.year,month: management.e_date.strftime("--%m"))
					else
						xml.Current true
					end
				}
				xml.Position{
					xml.Label management.role.name
				}
				xml.Activities management.description
				xml.Employer{
					xml.Name management.entity.name
				}
			}
		end

		def addEducationList(xml)
			xml.EducationList{
				@teacher.academic_informations.order(e_date: :desc).each do |academic_information|
					addEducation xml, academic_information
				end
			}
		end

		def addEducation(xml,academic_information)
			byear = academic_information.b_date.year
			bmonth = academic_information.b_date.strftime("--%m")
			eyear = academic_information.e_date.year
			emonth = academic_information.e_date.strftime("--%m")

			xml.Education{
				xml.Period{
					xml.From(year: byear, month: bmonth)
					xml.To(year: byear, month: bmonth)
				}
				xml.Title academic_information.course.name
				xml.Organisation{
					xml.Name academic_information.institution.name
				}
			}
		end

	end
end

