# # TODO: Write documentation for `Url::Checker`
# module Url::Checker
#   VERSION = "0.1.0"

#   # TODO: Put your code here
# end
require "http/client"
require "yaml"

# reads over the yml file and creates and array of strings
# p YAML.parse(File.read("../urls.yml"))["urls"].as_a.map(&.as_s).class

#the above code reafactored to a proc
get_urls = -> {
  file_lines = File.read("../urls.yml")
  YAML.parse(file_lines)["urls"].as_a.map(&.as_s)
}
p get_urls.call

#function to get the status of a url, dont forget to specify the type in the params
get_status = ->(url : String) {
  begin
    # puts "calling #{url}" - debugging to see sequence of output
  response = HTTP::Client.get url
  {url, response.status_code}
  rescue e : IO::Error | Socket::Addrinfo::Error #in crystal you can specify normal error or specific
    {url, e}
  ensure
  #   puts "called #{url}" - debugging to see sequence of output
  end
}
#create channel to run concurrently (creating the generator and channel)
# the 'send' is a blocking code, so spawn is needed to await the result
url_stream = Channel(String).new
result_stream = Channel({String, Int32 | Exception }).new
spawn do
  get_urls.call.each { |url|
    url_stream.send url
  }
end

#create workers
#loop do within spawn so that each value in the yml is processed rather than just the 2 times specified before the spawn
2.times {
  spawn do
    loop do
      url = url_stream.receive
      result = get_status.call(url)

      result_stream.send result
    end
  end
}
#printer

stats = Hash(String, {success: Int32, failure: Int32}).new({success: 0, failure: 0})
loop do
  url, result = result_stream.receive
  current_value = stats[url]
  case result
  when Int32
    if result < 400
      stats[url] = {
      success: current_value["success"] + 1,
      failure: current_value["failure"]
    }
    else
      stats[url] = {
      success: current_value["success"],
      failure: current_value["failure"] + 1
    }
    end
  when Exception
      stats[url] = {
      success: current_value["success"],
      failure: current_value["failure"] + 1
    }
  end
  p stats
end



#2 workers but one main channel so that both workers are pushing the result to the channel
# url_generator -> [url] -> worker_0 -> [{url, result}]
#                         \_worker_1_/                          


#puts get_urls.call #array(string)
# .map(&get_status).join("\n")

# p get_status(get_urls.call.first)
#to get google.com using http client
# response = HTTP::Client.get "http://www.google.com"
# p response.status_code