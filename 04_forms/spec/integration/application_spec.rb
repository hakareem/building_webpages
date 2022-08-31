require "spec_helper"
require_relative '../../app'
require "rack/test"

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # Declare the `app` value by instantiating the Application so our tests work.
  let(:app) { Application.new }

  context "GET /form" do
    it 'returns html form' do
      response = get('/form')
      expect(response.status).to eq(200)
      expect(response.body).to include('<form action="/names" method="POST">')
      expect(response.body).to include('<input type="text" name="name" placeholder="name">')
    end
  end

  context 'POST /names' do
    it 'returns a user name page' do
      response = post('/names', name:'H',age:'99')
      expect(response.status).to eq(200)
      expect(response.body).to include('<h1>Name: H</h1>')
      expect(response.body).to include('<h2>Age: 99</h2>')
    end
  end

  context 'GET /albums/new' do
    it 'returns a html form to fill out' do
      response = get('/albums/new')
      expect(response.status).to eq(200)
      expect(response.body).to include('<form action="/albums" method="POST">')
    end
  end

  context 'POST /albums' do
    it 'validates form parameters' do
      response = post('/albums', wind: 'Strong', how: 'Long')
      expect(response.status).to eq(400)
    end

    it 'creates a new album record' do
      response = post('/albums', title: 'Joker', release_year: '1999', artist_id: '2')
      expect(response.status).to eq(200)
      expect(response.body).to eq('')

      response = get('/albums')
      expect(response.body).to include('Joker')
    end
  end

  context 'GET /artists/new' do
    it 'returns html form to create an artist record' do
      response = get('/artists/new')
      expect(response.status).to eq(200)
      expect(response.body).to include('<form action="/artists" method="POST">')
    end
  end

  context 'POST /artists' do
    it 'validates response params' do
      response = post('/artists', shame: 'huh?', getter: '?')
      expect(response.status).to eq(400)
    end

    it 'returns list of artist with newly created record' do
      response = post('/artists', name: 'Mike', genre: 'Mars')
      expect(response.status).to eq(200)
      expect(response.body).to eq('')

      response = get('/artists')
      expect(response.body).to include('Name: Mike')
    end
  end
end