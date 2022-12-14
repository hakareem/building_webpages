require "sinatra"
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'
require_relative 'lib/album'
require_relative 'lib/artist'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/views' do
    @name = params[:name]
    erb :index
  end

  get '/loops' do
    @list = ['A','B','C']
    return erb :loop
  end

  get '/password' do
    @passowrd = params[:password]
    return erb :conditional
  end

  get '/albums' do
    repo = AlbumRepository.new
    albums = repo.all
    response = albums.map do |album|
      album.title
    end.join(",")
    return response 
  end

  post '/albums' do
    repo = AlbumRepository.new
    album = Album.new
    album.title = params[:title]
    album.release_year = params[:release_year]
    album.artist_id = params[:artist_id]

    repo.create(album)
  end

  get '/artists' do
    repo = ArtistRepository.new
    artists = repo.all.map do |artist|
      artist.name
    end.join(",")
    return artists
  end


  post '/artists' do
    repo = ArtistRepository.new
    artist = Artist.new
    artist.name = params[:name]
    artist.genre = params[:genre]

    repo.create(artist)
  end
end