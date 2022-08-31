require "spec_helper"
require_relative '../../app'
require "rack/test"

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # Declare the `app` value by instantiating the Application so our tests work.
  let(:app) { Application.new }

  context 'GET /views' do
    it 'returns the html page' do
      reponse = get('/views', name: 'Xi') 
      expect(reponse.body).to include('<h1>Hi Xi </h1>')
    end
  end 

  context 'GET /loops' do
    it 'returns list of items' do
      response = get('/loops')
      expect(response.body).to include('<h6> A </h6>')
    end
  end

  context 'GET /passwords' do
    it 'returns string get in if password is correct' do
      response = get('/password', password: 'ten')
      expect(response.body).to include("Get in")
    end
    
    it 'returns string get out if password is wrong' do
      response = get('/password', password: 'five')
      expect(response.body).to include("Get out")
    end
  end

  context 'GET /albums' do
    it "returns list of albums" do
      response = get('/albums')
      result = 'Surfer Rosa,Waterloo,Super Trouper,Bossanova,Lover,Folklore,I Put a Spell on You,Baltimore,Here Comes the Sun,Fodder on My Wings,Ring Ring'

      expect(response.status).to eq(200)
      expect(response.body).to eq(result)
    end
  end

  context 'POST /albums' do
    it "creatrs a new album record" do
      response = post('/albums', title: 'raid', release_year: '1992', artist_id: '1')

      expect(response.status).to eq(200)
      expect(response.body).to eq('')

      response = get('/albums')
      expect(response.body).to include('raid')
    end
  end

  context 'GET /artists' do
    it "returns a list of artists" do
      response = get('/artists')
      expect(response.status).to eq(200)
      expect(response.body).to eq('Pixies,ABBA,Taylor Swift,Nina Simone,Kiasmos')
    end
  end

  context 'POST /artists' do
    it 'creates a new artist record' do
      response = post('/artists', name: 'Wild nothing', genre: 'Indie') 
      expect(response.status).to eq(200)
      expect(response.body).to eq('')

      response = get('/artists') 
      expect(response.body).to include('Wild nothing')
    end
  end
end