require "oai-pmh/list_set.rb"
require "oai-pmh/identify.rb"
require "oai-pmh/list_metadata_formats.rb"

class OaiController < ApplicationController
	def index
		options = params.delete_if { |k,v| %w{controller action}.include?(k) }


		case options["verb"]
		when "ListSets"
			response = OaiPmh::ListSet.new("#{request.base_url}/oai")
		when "Indentify"
			response = OaiPmh::Identify.new("#{request.base_url}/oai")
		when "ListMetadataFormats"
			response = OaiPmh::ListMetadataFormats.new("#{request.base_url}/oai")
		else
		end
		render :text => response.xml, :content_type => 'text/xml'
	end
end
