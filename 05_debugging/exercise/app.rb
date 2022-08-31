require "sinatra"
require "sinatra/reloader"
require_relative 'lib/postcode_checker.rb'


class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  get '/check' do
    return erb(:check)
  end
  
  post '/check' do
    checker = PostcodeChecker.new
    postcode = params[:postcode]
    @valid = checker.valid?(postcode)

    erb :check
  end
end