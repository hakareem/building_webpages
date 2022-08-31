require 'sinatra/base'
require "sinatra/reloader"

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    return erb(:index)
  end

  post '/hello' do
    if special_chars? || params[:name].length > 15
      status 400
    return ''
    end

    @name = params[:name]

    return erb(:hello)
  end

  def special_chars?
  return (params[:name].include?(".") || params[:name].include?("!") || params[:name].include?("@") || params[:name].include?("$") )  
  end
end

# preventing a parameter containing special characters to be processed, or by "escaping" the HTML present in some text