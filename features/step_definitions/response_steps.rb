
Then /^the responded status code should be (\d+)$/ do |status_code|
  response.status.should == status_code.to_i
end
