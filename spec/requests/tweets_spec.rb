require 'rails_helper'

RSpec.describe 'Tweets API', type: :request do
    # add tweets owner
    let(:user) { create(:user) }
   
    # initialize test data
    let!(:tweets) { create_list(:tweet, 10, created_by: user.id) }
    let(:tweet_id) { tweets.first.id }
    
    # authorize request
    let(:headers) { valid_headers }

    # Test suite for GET /tweets
    describe 'GET /tweets' do
        before { get '/tweets', headers: headers }

        it 'returns tweets' do
            expect(json).not_to be_empty
            expect(json.size).to eq(10)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end

    # Test suite for GET /tweets/:id
    describe 'GET /tweets/:id' do
        before { get "/tweets/#{tweet_id}", headers: headers }

        context 'when the record exists' do
            it 'returns the tweets' do
                expect(json).not_to be_empty
                expect(json['id']).to eq(tweet_id)
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'when the record does not exist' do
            let(:tweet_id) { 100 }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Tweet/)
            end
        end
    end

    # Test suite for POST /tweets
    describe 'POST /tweets' do
        # valid payload
        let(:valid_attributes) do
            { tweet: 'Learn Elm', created_by: user.id.to_s }.to_json
        end

        context 'when the request is valid' do
            before { post '/tweets', params: valid_attributes, headers: headers }

            it 'creates a tweet' do
                expect(json['tweet']).to eq('Learn Elm')
            end

            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when the request is invalid' do
            let(:invalid_attributes) { { title: nil }.to_json }
            before { post '/tweets', params: invalid_attributes, headers: headers }

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a validation failure message' do
                expect(response.body).to match(/Validation failed: Tweet can't be blank/)
            end
        end
    end

    # Test suite for PUT /tweets/:id
    describe 'PUT /tweets/:id' do
        let(:valid_attributes) { { tweet: 'floof boi' }.to_json }

        context 'when the record exists' do
            before { put "/tweets/#{tweet_id}", params: valid_attributes, headers: headers }
      
            it 'updates the record' do
                expect(response.body).to be_empty
            end

            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end
        end
    end

    # Test suite for DELETE /todos/:id
    describe 'DELETE /tweets/:id' do
        before { delete "/tweets/#{tweet_id}", headers: headers }

        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end
    end
end