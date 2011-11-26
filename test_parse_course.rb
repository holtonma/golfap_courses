#!/usr/bin/env ruby

require 'rubygems'
require 'mechanize'
#require 'parse_course.rb'

require  './parse_course.rb'
# File.expand_path(File.dirname(__FILE__) +
#$: << File.join(File.dirname(__FILE__), "/../lib")
#require 'parse_course.rb'

a = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }

url = "http://www.pga.com/golf-courses/details/il/glenview/glenview-park-golf-club"
course = {:name => "Glenview Park GC", :address => "123 Shermer Road", :city =>"Glenview", :state => "IL",
          :zip  => "60025", :phone => "(847) 555-1212" }
parser = ParseCourse.new(url, a, course)

puts parser.parse
#puts a.page.search("div#block-course-course_scorecard table.course-tees-summary").text
