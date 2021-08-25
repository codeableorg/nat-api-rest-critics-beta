require 'rails_helper'
describe 'Genres', type: :request do

  describe 'index path' do
    it 'respond with http success status code' do
      get '/api/genres'
      expect(response).to have_http_status(:ok)
    end

    it 'returns a json with all genres' do
      Genre.create(name: 'Test')
      get '/api/genres'
      genres = JSON.parse(response.body)
      expect(genres.size).to eq 1
    end
  end

  describe 'show path' do
    it 'respond with http success status code' do
      genre = Genre.create(name: 'Test')
      get api_genre_path(genre)
      expect(response).to have_http_status(:ok)
    end
  
    it 'respond with the correct genre' do
      genre = Genre.create(name: 'Test')
      get api_genre_path(genre)
      actual_genre = JSON.parse(response.body)
      expect(actual_genre['id']).to eql(genre.id)
    end

    it 'returns http status not found' do
      get '/api/genres/:id', params: { id: 'xxx' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'create path' do
    it 'created a new genre' do
      post '/api/genres', :params => { :genre => {:name => "test2"} }
      expect(response).to have_http_status :ok
    end

    it 'increment by one count genres' do
      expect { post '/api/genres', :params => { :genre => {:name => "test2"} } }.to change(Genre, :count).by(+1)
    end
  end

  describe 'update a genre' do
    it 'update a genre' do
      genre = Genre.create(name: 'Test')
      patch api_genre_path(genre), :params => { :genre => { :name => "Test2"} }
      expect(Genre.last['name']).to eq 'Test2'
    end

    it 'returns HTTP status ok' do
      genre = Genre.create(name: 'Test')
      patch api_genre_path(genre), :params => { :genre => { :name => "Test2"} }
      expect(response).to have_http_status(200)
    end
  end

  describe 'destroy a genre' do
    before(:each) do
      @genre = Genre.create(name: 'Test')
    end

    it 'returns HTTP status no content' do
      delete api_genre_path(@genre)
      expect(response).to have_http_status(:no_content)
    end

    it 'returns empty body' do
      delete api_genre_path(@genre)
      expect(response.body).to be_empty
    end

    it 'decrement by 1 the total of categories' do
      expect{ delete api_genre_path @genre}.to change(Genre, :count).by(-1)
    end

    it 'delete the requested genre' do
      delete api_genre_path(@genre)
      expect { Genre.find(@genre.id) }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end
end