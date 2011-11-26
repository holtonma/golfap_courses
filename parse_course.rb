
class ParseCourse
  attr_accessor :url, :html_fragment, :agent
  
  def initialize url, agent, course
    @url              = url
    @agent            = agent
    @agent.get(url)
    @tee_summary_frag = @agent.page.search("div#block-course-course_scorecard table.course-tees-summary")
    @tee_details_out  = @agent.page.search("div#block-course-course_scorecard table.course-tees-front-nine")
    @tee_details_in   = @agent.page.search("div#block-course-course_scorecard table.course-tees-back-nine")
    @course           = course 
      # {:name => "Glenview Park GC", :address => "123 Shermer Road", :city =>"Glenview", :state => "IL"
      #  :zip  => "60025", :phone => "(847) 555-1212" }
    @tees             = []
  end
  
  def grab_hole_yardages
    
  end
  
  def grab_hole_pars
  end
  
  def tees_summary
    # for each row in tees summary, create a tee with empty arrays for hole_yardages, and hole_pars
    #puts @tee_summary_frag
    rows = @tee_summary_frag.css('table.course-tees-summary tbody tr')
    
    num_tees = rows.length # - 1 # don't count HOLE row, or PAR row
    
    rows.each do |table_row| # each row is a tee except first
      i   = 0
      row = 0
      tee = {:course => @course, :hole_yardages => [], :hole_pars => []}
      
      table_row.css('td').each do |cell|
        col = i%5
        if    col == 0
          tee[:tee]     = cell.inner_html
        elsif col == 1
          tee[:par]     = cell.inner_html
        elsif col == 2
          tee[:rating]  = cell.inner_html
        elsif col == 3
          tee[:slope]   = cell.inner_html
        elsif col == 4
          tee[:yardage] = cell.inner_html
          # reached end, so stuff that into array, and start new
          row += 1
        end
        
        i += 1
      end
      @tees << tee
        
      
    end # end each row
    puts "tees.length #{@tees.length}"
    @tees.each do |t|
      puts t
    end
    
    # for each row in table, keep it if it looks like:
    # <tr class="course-tee-forward forward odd"><td>Forward tee</td><td>70</td><td>68.6</td><td>118</td><td>6,077</td></tr>
    
  end
  
  def parse
    #puts a.page.search("div#block-course-course_scorecard table.course-tees-summary").text
    tees_summary
    puts "-----------------"
    #puts @tee_details_out
    puts "-----------------"
    #puts @tee_details_in
    puts "-----------------"
    #puts @course
  end
  
  
end

# course_parser = ParseCourse.new(url, agent)
# tees = course_parser.parse
# => [
#      {
#        :course => @course, :tee => "Forward tee", :par => 70, :rating => "68.5", :slope => "119", :yardage => "6080"
#        :hole_yardages => [323, 398, 414, 416, 414, 183, 553, 307, 180, 193, 374, 381, 346, 320, 348, 477, 132, 318],
#        :hole_pars     => [4, 4, 4, 4, 4, 3, 5, 4, 3, 3, 4, 4, 4, 4, 4, 5, 3, 4]
#      },
#      {
#        :course => @course, :tee => "Red tee", :par => 70, :rating => "68.5", :slope => "119", :yardage => "6080"
#        :hole_yardages => [176, 362, 360, 331, 306, 335, 453, 113, 302, 281, 375, 384, 400, 399, 172, 531, 290, 164],
#        :hole_pars     => [4, 4, 4, 4, 4, 3, 5, 4, 3, 3, 4, 4, 4, 4, 4, 5, 3, 4]
#      },
#      {
#        :course => @course, :tee => "White tee", :par => 70, :rating => "68.5", :slope => "119", :yardage => "6080"
#        :hole_yardages => [323, 398, 414, 416, 414, 183, 553, 307, 180, 193, 374, 381, 346, 320, 348, 477, 132, 318],
#        :hole_pars     => [4, 4, 4, 4, 4, 3, 5, 4, 3, 3, 4, 4, 4, 4, 4, 5, 3, 4]
#      },
#      
#    ]
