#!/usr/bin/ruby
require 'fileutils'
require 'sinatra'
require 'json'
require './renamer.rb'

include FileUtils::Verbose

stuffs = {}

use Renamer

def file_listing(directory)
  Dir.glob(directory + '/*')
end

get '/' do
  "Welcome to my sinatra API, here you can add stuff to the API by POSTing json to /stuff endpoint."
end

get '/stuff' do
  logger.info "Someone saw the stuff"
  stuffs.inspect
end

post '/stuff' do
  stuff = JSON.parse(request.body.read).to_h
  stuffs.merge!(stuff)
  logger.info "Got a new stuff"
end

put '/stuff/:name' do
  stuffs.merge!(params)
  logger.info "Got a named stuff"
end

# patch '/stuff/:name' do
# end

get '/upload' do
  haml :upload
end

post '/upload' do
  tempfile = params[:file][:tempfile] 
  filename = params[:file][:filename] 
  cp(tempfile.path, "public/uploads/#{filename}")
  #"File uploaded"
  params.to_s
end

get '/download' do
  @files = file_listing("public/uploads/")
  haml :download
end