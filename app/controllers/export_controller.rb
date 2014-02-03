require 'export/europass.rb'
class ExportController < ApplicationController
	before_action :init, only: [:xml, :pdf]

	def xml
		send_data @xml.xml, filename: "europass.xml", type: "application/xml"
	end

	def pdf
		send_data @xml.pdf, filename: "europass.pdf", type: "application/pdf"
	end

	private
	def init
		@xml = Export::Europass.new current_teacher.id
	end
end
