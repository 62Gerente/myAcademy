require 'export/europass.rb'
require 'export/json_report.rb'

class ExportController < ApplicationController
  before_action :init_europass, only: [:europass_xml, :europass_pdf]
  before_action :init_report, only: [:latex_pdf, :md]

  def europass_xml
    send_data @xml.xml, filename: "europass.xml", type: "application/xml"
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

  private
  def init_europass
    @xml = Export::Europass.new current_teacher.id
  end
  def init_report
    @resume = Export::JsonReport.new current_teacher.id
  end
end
