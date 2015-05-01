namespace :subreddits do
  desc "Fetches list of subreddits from the .json endpoint and saves them into tmp/subreddits.json, usually for upload to a CDN"
  task :fetch do
    first_url = "http://www.reddit.com/reddits.json?limit=100"
    url_template = "http://www.reddit.com/reddits.json?limit=100&after=AFTER_REPLACEMENT"
  
    absolute_max = 150
  
    running_total = 0
    current_url = first_url
  
    while running_total < absolute_max do
      result_hash = ActiveSupport::JSON.decode(Net::HTTP.get(URI.parse(current_url)))
      next_after = result_hash['data']['after']
      result_hash['data']['children'].each do |child|
        puts [ child['data']['url'][3..-2], child['data']['over18'], child['data']['subscribers'], child['data']['public_description'] ].to_json
        running_total += 1
      end
      current_url = url_template.gsub(/AFTER_REPLACEMENT/, next_after)
      puts "Roundtrip complete, going to start on #{next_after}"
    end

    puts "Found: #{running_total}"
  end
end