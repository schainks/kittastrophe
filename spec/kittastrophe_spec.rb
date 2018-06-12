require 'kittastrophe/client'

require 'curb'

require 'optparse'
require 'json'

RSpec.describe Kittastrophe::Client do
  ## Messy!
  let(:token) { "token" }
  let(:list_response) { {"kits"=>[{"id"=>"inp1avm", "link"=>"/api/v1/json/kits/ooga"}]} }
  let(:kit_response) { {"kit"=>{"id"=>"zaj1tal", "families"=>[{"css_stack"=>"\"droid-sans\",sans-serif", "slug"=>"droid-sans", "name"=>"Droid Sans", "css_names"=>["droid-sans"], "id"=>"gkmg", "subset"=>"default", "variations"=>["n4", "n7"]}], "domains"=>["ooga.net"], "optimize_performance"=>false, "name"=>"Ooga", "analytics"=>false}} }
  let(:list_empty_response) { {"kits" => []} }
  let(:unauthorized_response) { {"errors"=>["Not authorized"]} }
  let(:not_found) { {"errors"=>["Not Found"]} }


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

  it "shows a specific kit by ID" do
    subject.instance_variable_set(:@api_key, token)

    stub = stub_request(:get, "https://typekit.com/api/v1/json/kits/ooga").
      with(headers: {'X-Typekit-Token': token }).
      to_return(:status => 200, :body => kit_response.to_json)
    expect(subject.show("ooga")).to eql(kit_response)
    expect(stub).to have_been_requested
  end

  it "shows asking for a kit that doesn't not exist" do

    subject.instance_variable_set(:@api_key, token)

    stub = stub_request(:get, "https://typekit.com/api/v1/json/kits/booga").
      with(headers: {'X-Typekit-Token': token }).
      to_return(:status => 404, :body => not_found.to_json)
    expect(subject.show("booga")).to eql(not_found["errors"])
    expect(stub).to have_been_requested
  end

  it "shows you are unauthorized" do
    subject.instance_variable_set(:@api_key, token)

    stub = stub_request(:get, "https://typekit.com/api/v1/json/kits").
      with(headers: {'X-Typekit-Token': token }).
      to_return(:status => 401, :body => unauthorized_response.to_json)
    expect(subject.list).to eql(unauthorized_response["errors"])
    expect(stub).to have_been_requested
  end

  it "loads api key from file" do
    ENV.delete('TYPEKIT_API_KEY')

    open(subject.key_path, 'w') do |f|
      f.puts "#{token}".strip
      f.close
    end
    expect(subject.read_api_key).to eql(token)
  end

  it "makes sure api key in ENV var has precedent over loaded file" do
    ENV["TYPEKIT_API_KEY"] = "z0idb3rg"
    allow(subject).to receive(:prompt) { token }
    subject.configure
    expect(subject.read_api_key).to eql(ENV["TYPEKIT_API_KEY"])
  end

end
