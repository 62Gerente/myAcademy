require "oai-pmh/list_set.rb"

class OaiController < ApplicationController
	def index
		options = params.delete_if { |k,v| %w{controller action}.include?(k) }
		puts options
		case options["verb"]
		when "ListSets"
			response = OaiPmh::ListSet.new("#{request.base_url}/oai")
		else
		end
		render :text => response.xml, :content_type => 'text/xml'
	end
end
