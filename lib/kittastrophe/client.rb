require 'curb'
require 'optparse'

module Kittastrophe
  class Client
    api_base_uri "https://typekit.com/api/v1/json"

    def zoidberg()
      "Hooray, I'm useful!"
    end

    def list()
      #key = read_api_key
      #http = Curl::Easy.perform(api_base_uri + '/list') do |curl|
      #  curl.headers["X-Typekit-Token"] = "token"
      #  # don't forget to use on_missing, on_failure, on_success
      #end
      #http.perform
      #http.body_str
      "haha"
    end

  end
end
