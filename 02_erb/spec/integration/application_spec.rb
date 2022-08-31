require "spec_helper"
require_relative '../../app'
require "rack/test"

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # Declare the `app` value by instantiating the Application so our tests work.
  let(:app) { Application.new }

  context 'GET /albums/:id' do
    it "returns ablums info" do
      response = get('/albums/2')
      expect(response.body).to include('<h1>Surfer Rosa</h1>')
      expect(response.body).to include('<h2>1988</h2>')
      expect(response.body).to include('<h3>Pixies</h3>')
    end
  end

  context 'GET /albums' do
    it "returns list of albums" do
      response = get('/albums')
      
      expect(response.status).to eq(200)
      expect(response.body).to include('Title: Ring Ring')
      expect(response.body).to include('Title: Here Comes the Sun')
      expect(response.body).to include('Released: 1971')
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