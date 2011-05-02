
Transform /^(\{.*\})$/ do |json|
  JSON.parse json
end

Then /^the responded status code should be (\d+)$/ do |status_code|
  response.status.should == status_code.to_i
end

Then /^the responded json should contain the key "([^"]+)"$/ do |key|
  hash = JSON.parse response.body
  hash.should have_key(key)
end

Then /^the responded json should not contain the key "([^"]+)"$/ do |key|
  hash = JSON.parse response.body
  hash.should_not have_key(key)
end

Then /^the responded json should be "(\{.*\})"$/ do |hash|
  response_hash = JSON.parse response.body
  response_hash.should == hash
end
