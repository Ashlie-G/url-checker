# # TODO: Write documentation for `Url::Checker`
# module Url::Checker
#   VERSION = "0.1.0"

#   # TODO: Put your code here
# end
require "http/client"
response = HTTP::Client.get "http://www.google.com"
p response.status_code