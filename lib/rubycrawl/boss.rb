require "rubycrawl/advisor"
require "rubycrawl/scout"

module RubyCrawl

	class Boss 

		CONCURRENCY = 4

		attr_reader :crawl
		attr_accessor :paths_in_level # obviously not an optimum way of holding these links but will do the job as a placeholder

		def initialize(seed, max_depth)
			@advisor = Advisor.new seed, max_depth 
			@paths_in_level = [seed]
		end

		def crawl 
			paths_pub = Queue.new
			paths_sub = Queue.new
			@paths_in_level.each{ |path| paths_sub << path }
			threads = []

			if @advisor.crawl.depth > @advisor.crawl.max_depth || paths_sub.empty?
				return true
			end

			CONCURRENCY.times do
				threads << Thread.new do
					until paths_sub.empty?
						path = paths_sub.pop(true) rescue nil
						if path
							# start the crawl process
							scout = Scout.new path
							begin
								source, paths = scout.report
								paths.each{ |path| paths_pub << path }
							rescue
							end

						end
					end
				end
			end
			threads.each { |t| t.join }

			@advisor.crawl.depth += 1 

			until paths_pub.empty?
				path = paths_pub.pop
				if @advisor.should_follow path
					puts path
					@paths_in_level.push(path)
					@advisor.crawl.visited.insert path 
				end
			end

			crawl
		end
	end
end
