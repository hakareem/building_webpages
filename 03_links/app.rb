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

  get '/' do
    erb :index
  end

  get '/about' do
    erb :about
  end

  get '/albums/:id' do
    repo = AlbumRepository.new
    artists = ArtistRepository.new
    id = params[:id]
    @album = repo.find(id)
    @artist = artists.find(@album.artist_id)

    return erb :find
  end


  get '/albums' do
    repo = AlbumRepository.new
    @albums = repo.all

    return erb :albums 
  end


  get '/artists' do
    repo = ArtistRepository.new
    @artists = repo.all

    erb :artists
  end
  
  get '/artists/:id' do
    repo = ArtistRepository.new
    @artist = repo.find(params[:id])
    erb :search
  end

  post '/albums' do
    repo = AlbumRepository.new
    album = Album.new
    album.title = params[:title]
    album.release_year = params[:release_year]
    album.artist_id = params[:artist_id]

    repo.create(album)
  end

  post '/artists' do
    repo = ArtistRepository.new
    artist = Artist.new
    artist.name = params[:name]
    artist.genre = params[:genre]

    repo.create(artist)
  end
end