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

#to get google.com using http client
# response = HTTP::Client.get "http://www.google.com"
# p response.status_code