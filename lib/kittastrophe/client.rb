require 'curb'
require 'optparse'
require 'json'

module Kittastrophe
  class Client

    @@KEY_PATH = File.join(Dir.home, ".typekit")

    def initialize()
      @api_key = read_api_key
    end


    def key_path
      @@KEY_PATH
    end


    def zoidberg
      "Hooray, I'm useful!"
    end


    def list
      http = Curl.get("https://typekit.com/api/v1/json/kits") do |http|
        http.headers['X-Typekit-Token'] = @api_key
      end

      body = JSON.parse(http.body_str)

      if http.response_code != 200
        process_error(body)
      else
        body
      end
    end

    def show(id)
      http = Curl.get("https://typekit.com/api/v1/json/kits/#{id}") do |http|
        http.headers['X-Typekit-Token'] = @api_key
      end

      body = JSON.parse(http.body_str)

      if http.response_code != 200
        process_error(body)
      else
        body
      end
    end


    def process_error(body)
      body["errors"]
    end


    def configure
      api_key = prompt "Please enter your TypeKit API key: "

      open(@@KEY_PATH, 'w') do |f|
        f.puts "#{api_key}".strip
        f.close
      end
    end


    def prompt(*args)
        print(*args)
        gets
    end


    def read_api_key
      if File.exists?(@@KEY_PATH)
        file = File.open(@@KEY_PATH, "rb")
        contents = file.read
        file.close
        key = contents.strip
      end

      ENV['TYPEKIT_API_KEY'] || key
    end
  end
end
