require "bundler/setup"
require "webmock/rspec"
include WebMock

require "kittastrophe"

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
end
