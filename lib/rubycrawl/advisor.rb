require 'bloom-filter'
require 'rubycrawl/crawl'

module RubyCrawl

	class Advisor
		# makes a desicion on wether or not a path should be followed

		attr_accessor :crawl

		def initialize(seed, max_depth)
			visited = BloomFilter.new size: 100_000, error_rate: 0.01
			@crawl = Crawl.new seed, max_depth, 0, visited 
		end

		def should_follow(link)
			if @crawl.max_depth < @crawl.depth
				return false
			end
			if @crawl.visited.include? link
				return false
			end

			true
		end
	end
end
