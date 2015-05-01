namespace :subreddits do
  desc "Fetches list of subreddits from the .json endpoint and saves them into tmp/subreddits.json, usually for upload to a CDN"
  task :fetch do
    file_path = File.expand_path('../../../tmp/subreddits.json', __FILE__)
    first_url = "http://www.reddit.com/reddits.json?limit=100"
    url_template = "http://www.reddit.com/reddits.json?limit=100&after=AFTER_REPLACEMENT"
    absolute_max = 800000
    
    if File.exist?(file_path)
      puts "ERROR: `#{file_path}` already exists, aborting!  Please move or delete the existing file."
    else
      running_total = 0
      current_url = first_url
      
      target_file = File.open(file_path, "w")
      target_file.puts "{"
      target_file << "\"column_names\":"+[ 'url_path', 'over18', 'subscribers', 'public_description' ].to_json
      target_file << ",\n"
      target_file.puts "\"subreddits\":["
      target_file.close
  
      while running_total < 200 do # absolute_max do
        result_hash = ActiveSupport::JSON.decode(Net::HTTP.get(URI.parse(current_url)))
        next_after = result_hash['data']['after']
        result_hash['data']['children'].each do |child|
          open(file_path, 'a') { |f|
            if running_total > 0
              f << ","
            end
            f << [ child['data']['url'][3..-2], child['data']['over18'], child['data']['subscribers'], child['data']['public_description'] ].to_json

          }
        
          running_total += 1
        end
        current_url = url_template.gsub(/AFTER_REPLACEMENT/, next_after)
        puts "Roundtrip complete, going to start on #{next_after}"
      end
      
      open(file_path, 'a') { |f|
        f.puts "]"
        f.puts "}"
      }
      puts "Found: #{running_total}, Wrote file: `#{file_path}`"
    end
  end
end