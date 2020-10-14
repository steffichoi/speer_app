require 'rails_helper'

RSpec.describe 'Chatrooms API', type: :request do
    # initialize test data
    let!(:user) { create(:user) }
    let!(:user_two) { create(:user) }
    let!(:user_three) { create(:user) }
    
    let!(:chatrooms) { create_list(:chatroom, 10, created_by: user.id) }
    
    let(:chatroom) { chatrooms.first }
    let(:chatroom_id) { chatroom.id }
    let(:chatroom_title) { chatroom.title }

    let(:headers) { valid_headers }

    # Test suite for GET /chatrooms
    describe 'GET /chatrooms' do
        # make HTTP get request before each example
        before { get '/chatrooms', headers: headers }

        it 'returns chatrooms' do
            expect(json).not_to be_empty
            expect(json.size).to eq(10)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end

    # Test suite for GET /chatrooms/:id
    describe 'GET /chatrooms/:id' do
        before { get "/chatrooms/#{chatroom_id}", headers: headers }

        context 'when the record exists' do
            it 'returns the user' do
                expect(json).not_to be_empty
                expect(json['id']).to eq(chatroom_id)
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'when the record does not exist' do
            let(:chatroom_id) { 100 }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Chatroom/)
            end
        end
    end

    # Test suite for POST /chatrooms
    describe 'POST /chatrooms' do
        # valid payload
        let(:valid_attributes) do
            # { title: 'Learn Elm', created_by: user.id.to_s, user_ids: [user_two.id.to_s, user_three.id.to_s]}.to_json
            { title: 'Learn Elm', created_by: user.id.to_s }.to_json
        end

        context 'when the request is valid' do
            before { post '/chatrooms', params: valid_attributes, headers: headers }

            it 'creates a chatroom' do
                expect(json['title']).to eq('Learn Elm')
                expect(json['created_by']).to eq(user.id.to_s)
                # expect(json['user_ids']).to eq([user_two.id, user_three.id])
            end

            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when the request is valid but chatroom exists' do
            let(:valid_attributes) { { title: chatroom.title, created_by: user.id.to_s }.to_json }
            before { post '/chatrooms', params: valid_attributes, headers: headers }

            it 'returns status code 409' do
                expect(response).to have_http_status(409)
            end

            it 'returns a validation failure message' do
                expect(response.body)
                    .to match(/Validation failed: Title has already been taken/)
            end
        end

        context 'when the request is invalid' do
            let(:invalid_attributes) { {chatroom: { title: nil }}.to_json }
            before { post '/chatrooms', params: invalid_attributes, headers: headers }

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a validation failure message' do
                expect(response.body)
                    .to match(/Validation failed: Creator must exist, Title can't be blank, Created by can't be blank/)
            end
        end
    end

    # Test suite for PUT /chatrooms/:id
    describe 'PUT /chatrooms/:id' do
        let(:valid_attributes) { { title: 'Shopping' }.to_json }

        context 'when the record exists' do
            before { put "/chatrooms/#{chatroom_id}", params: valid_attributes, headers: headers }

            it 'updates the record' do
                expect(response.body).to be_empty
            end

            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end
        end
    end

    # Test suite for DELETE /chatrooms/:id
    describe 'DELETE /chatrooms/:id' do
        before { delete "/chatrooms/#{chatroom_id}", headers: headers }

        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end
    end
end