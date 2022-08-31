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

  get '/form' do
    erb :form
  end

  post '/names' do
    @name = params[:name]
    @age = params[:age]
    erb :names_form
  end

  get '/albums/new' do
    erb :add_album
  end

  get '/albums' do
    repo = AlbumRepository.new
    @albums = repo.all

    return erb :albums 
  end

  get '/albums/:id' do
    repo = AlbumRepository.new
    artists = ArtistRepository.new
    id = params[:id]
    @album = repo.find(id)
    @artist = artists.find(@album.artist_id)

    return erb :find
  end

  post '/albums' do
    if invalid_album_params?
      status 400
      return ''
    end

    repo = AlbumRepository.new
    album = Album.new
    album.title = params[:title]
    album.release_year = params[:release_year]
    album.artist_id = params[:artist_id]

    repo.create(album)
  end

  get '/artists/new' do
    erb :add_artist
  end

  get '/artists' do
    repo = ArtistRepository.new
    @artists = repo.all
    erb :artists
  end

  get '/artists/:id' do
    repo = ArtistRepository.new
    id = params[:id]
    @artist = repo.find(id)
    erb :artist_id
  end

  post '/artists' do
    if invalid_artist_params?
      status 400
      return ''
    end

    repo = ArtistRepository.new
    artist = Artist.new
    artist.name = params[:name]
    artist.genre = params[:genre]

    repo.create(artist)
  end

  def invalid_album_params?
    return (params[:title] == nil || params[:release_year] == nil || params[:artist_id] == nil)
  end

  def invalid_artist_params?
    return (params[:name] == nil || params[:genre] == nil)
  end
end