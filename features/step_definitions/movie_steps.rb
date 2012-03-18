# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    Movie.create!(movie)      
  end
  assert Movie.count>0, "Movie list not created"
  
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page


Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.content  is the entire content of the page as a string.
  #assert false, "Unimplmemented"
  assert page.body.match(/<td>#{e1}<\/td>.*<td>#{e2}<\/td>/m), "Error in movie order"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  
    rating_list.split(/,/).each do |field|
      if uncheck
        uncheck("ratings[#{field}]")
      else
        check("ratings[#{field}]")
      end
    end  
end
Then /I should see "(.*)" and "(.*)"/ do |e1,e2|
  assert (page.has_content?("#{e1}") and page.has_content?("#{e2}")),"Error in Filtering"
  assert page.has_no_content?("Chocolat")
  #assert (e1!="Chicken Run" and e2!="The Help"), "Error in Filtering"
end
Then /I should see all the movies/ do 
	
	#assert all("tr").count==11

end
