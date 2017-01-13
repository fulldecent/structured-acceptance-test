Given(/^the program has finished$/) do
  # Test files are generated using iconv.

  @cucumber = `ruby junit-stat-converter.rb features/steps/junit1.xml`
  @cucumber2 = `ruby junit-stat-converter.rb features/steps/junit2.xml`
end

Then(/^the output is correct for each test$/) do
  stat = JSON.parse(@cucumber)
  expect(stat['statVersion']).to match('1.0.0')

  stat = JSON.parse(@cucumber2)
  expect(stat['statVersion']).to match('1.0.0')
end
