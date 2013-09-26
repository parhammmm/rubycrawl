# a data structure to hold the current state of the crawl
module RubyCrawl
	Crawl = Struct.new(:seed, :max_depth, :depth, :visited) do
	end
end
