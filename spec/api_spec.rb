require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'api' do
  it "should get home page" do
    get '/'
    last_response.should be_ok
    assert last_response.body.include?('Welcome to my sinatra API')
  end
end