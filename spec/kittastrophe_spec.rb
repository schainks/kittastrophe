require 'kittastrophe/client'

require 'curb'

require 'optparse'
require 'json'

RSpec.describe Kittastrophe::Client do
  ## sample /list output
  #    {
  #       "kits" : [
  #          {
  #             "id" : "inp1avm",
  #             "link" : "/api/v1/json/kits/inp1avm"
  #          }
  #       ]
  #    }
  let(:list_response) { {"kits" => [{ "id" => "foobars", "link" => "/api/v1/json/kits/foobars"}]} }

  it "has a wonderful time" do
    expect(Kittastrophe::Client.new.zoidberg()).to eql("Hooray, I'm useful!")
  end

  it "lists available kits" do
    stub = stub_request(:get, "https://typekit.com").
      with(headers: {'X-Typekit-Token': "blah"}).
      to_return(:status => [200, response.to_json])
    expect(Kittastrophe::Client.new.list()).to eql("haha")
    expect(stub).to have_been_requested
  end

  #test for config
  # test for list
  # test for show
end
