require 'test/unit'
require 'rubycrawl/advisor'

class TestAdvisor < Test::Unit::TestCase

	def test_should_follow_depth
		seed = 'http://parha.me'
		max_depth = 10

		advisor = RubyCrawl::Advisor.new seed, max_depth 

		advisor.crawl.depth = 9 
		should_follow = advisor.should_follow seed
		assert(should_follow, 'this link should be followed')

		advisor.crawl.depth = 11
		should_follow = advisor.should_follow seed
		assert(!should_follow, 'this link should not be followed')
	end

	def test_should_follow_loop
		seed = 'http://parha.me'
		max_depth = 10

		advisor = RubyCrawl::Advisor.new seed, max_depth 
		should_follow = advisor.should_follow seed
		assert(should_follow, 'this link should be followed')

		advisor.crawl.visited.insert seed 
		should_follow = advisor.should_follow seed
		assert(!should_follow, 'this link should not be followed')
	end

end
