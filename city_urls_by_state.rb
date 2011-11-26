require 'rubygems'
require 'mechanize'

#a = WWW::Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }
a = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }

# ul li a
states = %w(AL AK AZ AR CA CO CT DE FL GA HI ID IL IN IA KS KY LA ME MD MA MI MN MS 
            MO MT NE NV NH NJ NM NY NC ND OH OK OR PA RI SC SD TN TX UT VT VA WA WV 
            WI WY)

root_url = "http://www.pga.com"

states.each do |state|
  puts "-------------- #{state} --------------"
  #puts a.get("http://www.pga.com/golf-courses/details/#{state}").search("div.view-courses div.item-list ul li a")
  #a.page.search(".edit_item")  

  a.get("http://www.pga.com/golf-courses/details/#{state}")  
  #a.page.link_with(:text => "Wish List").click  
  a.page.search("div.view-courses div.item-list ul li a").map{|link| link['href']}.each do |city_href|  
    city_url = root_url + city_href
    puts " city : #{city_url}" #*#{city.text}*
    a.get(city_url)
    
    a.page.search("div.view-content div.item-list ol li div.views-field-title span a").map{|link| link['href']}.each do |course_href|
      # grab course name
      # course info
      course_url = root_url + course_href
      puts "****** course: #{course_url}"
      a.get(course_url)
      puts a.page.search("div#block-course-course_scorecard table.course-tees-summary").text
    end
    
    puts
    
  end
  
end