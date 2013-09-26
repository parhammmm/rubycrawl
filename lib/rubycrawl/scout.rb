require 'uri'
require 'rest_client'
require 'nokogiri'

module RubyCrawl

	class Scout 

		attr_reader :path

		def initialize(path)
			@path = path
		end

		def report 
			# check and download a page
			response = RestClient.get @path 

			if response.code != 200
				raise "couldn't access page"
			end
			source = response.to_str 
			return source, extract_links(source)
		end


		private


		def extract_links(source)
			# parse html then extract and normalise all internal and external links
			links = []
			page = Nokogiri::HTML(source)
			raw_links = page.css('a')
			for raw_link in raw_links
				begin
					normalised_link = normalise_link raw_link.attr('href') 
					links.push(normalised_link)
				rescue
				end
			end
			links
		end

		def normalise_link(raw_link)
			clean_link = raw_link
			parts = URI.split(raw_link)
			if parts[2].nil? # for relative paths
				clean_link = URI.join(@path, raw_link)
			end
			clean_link
		end
	end
end
