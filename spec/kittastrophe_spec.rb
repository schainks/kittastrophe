require 'kittastrophe/client'

require 'curb'
require 'optparse'

RSpec.describe Kittastrophe::Client do
  it "says hi" do
    expect(Kittastrophe::Client.hi()).to eql("Schleeb")
  end
end
