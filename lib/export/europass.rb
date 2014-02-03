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
				addDocumentInfo(xml)
				addLearnerInfo(xml)
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

		def addPrintingPreferences
		end

		def addLearnerInfo(xml)
			xml.LearnerInfo{
				addIdentification(xml)
				addWorkExperienceList(xml)
			}
		end

		def addIdentification(xml)
			xml.Identification{
				addPersonName(xml)
				addContactInfo(xml)
				addDemographics(xml)
				addPhoto(xml) if @teacher.photo?
			}
		end

		def addPersonName(xml)
			xml.PersonName{
				xml.FirstName @teacher.name
			}
		end

		def addContactInfo(xml)
			xml.ContactInfo{
				addEmail(xml)
				addTelephoneList(xml)
				addWebsiteList(xml)
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
				addBirthdate(xml)
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

		def addWorkExperienceList(xml)
			xml.WorlExperienceList{}
		end

		def addEducationList(xml)
			xml.addEducationList{}
		end



	end
end

