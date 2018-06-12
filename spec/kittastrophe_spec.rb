require 'kittastrophe/client'

require 'curb'

require 'optparse'
require 'json'

RSpec.describe Kittastrophe::Client do
  let(:token) { "token" }
  let(:list_response) { {"kits"=>[{"id"=>"inp1avm", "link"=>"/api/v1/json/kits/inp1avm"}]} }
  let(:error_response) { '''{
                               "errors" : [
                                  "Not Found"
                               ]
                            }''' }

  let(:list_empty_response) { {"kits" => []} }


  it "has a wonderful time" do
    expect(subject.zoidberg()).to eql("Hooray, I'm useful!")
  end

  it "lists available kits" do
    subject.instance_variable_set(:@api_key,  token)

    stub = stub_request(:get, "https://typekit.com/api/v1/json/kits").
      with(headers: {'X-Typekit-Token': token }).
      to_return(:status => 200, body: list_response.to_json)
    expect(subject.list).to eql(list_response)
    expect(stub).to have_been_requested
  end

  it "lists empty kit list" do
    subject.instance_variable_set(:@api_key, token)

    stub = stub_request(:get, "https://typekit.com/api/v1/json/kits").
      with(headers: {'X-Typekit-Token': token }).
      to_return(:status => 200, :body => list_empty_response.to_json)
    expect(subject.list).to eql(list_empty_response)
    expect(stub).to have_been_requested
  end

  it "shows a specific kits by ID" do

  end

  it "shows that you asked for a kit that isn't there" do

  end

  it "shows you are unauthorized" do

  end

  it "loads api key from file" do
    # make key file with stubbed key
    # unset the ENV Var
    ENV.delete('TYPEKIT_API_KEY')

    open(subject.key_path, 'w') do |f|
      f.puts "#{token}".strip
      f.close
    end
    expect(subject.read_api_key).to eql(token)
  end

  it "loads api key from env var" do

  end

  it "makes sure api key in ENV var has precedent over loaded file" do

  end

  it "configures an api key" do

  end

end
