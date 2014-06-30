require 'export/europass.rb'
require 'export/json_report.rb'
require 'export/xslfo.rb'

class ExportController < ApplicationController
  before_action :init_europass, only: [:europass_xml, :europass_pdf]
  before_action :init_report, only: [:latex_pdf, :md]
  before_action :init_xslfo, only: [ :xslfo]

  def europass_xml
    render :text => @xml.xml, :content_type => 'text/xml'
  end

  def europass_pdf
    send_data @xml.pdf, filename: "europass.pdf", type: "application/pdf"
  end

  def latex_pdf
    @resume.pdf
    loc = Rails.root.join('public/system/export',"#{current_teacher.id}.pdf")
    send_file(loc, :filename => "resume.pdf", :disposition => 'inline', :type => "application/pdf")
  end

  def md
    @resume.md
    loc = Rails.root.join('public/system/export',"#{current_teacher.id}.md")
    @md = File.read loc
  end

	def xslfo
		@xslfo.save
		loc = Rails.root.join('public/system/export',"#{current_teacher.id}.pdf")
    send_file(loc, :filename => "#{current_teacher.id}", :disposition => 'inline', :type => "application/pdf")
	end

  private
  def init_europass
    @xml = Export::Europass.new current_teacher.id
  end
  def init_report
    @resume = Export::JsonReport.new current_teacher.id
  end
  def init_xslfo
  	@xslfo = Export::XSLFO.new current_teacher.id
  end
end
