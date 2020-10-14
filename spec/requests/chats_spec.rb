require 'rails_helper'

RSpec.describe 'Chats API', type: :request do
    # Initialize the test data
    let!(:user) { create(:user) }
    let!(:chatroom) { create(:chatroom, created_by: user.id) }
    # let!(:user) { create(:user) }
    let(:user_id) { user.id }
    let!(:chats) { create_list(:chat, 20, chatroom_id: chatroom.id, user_id: user.id) }
    let(:id) { chats.first.id }
    let(:chatroom_id) { chatroom.id }
    let(:headers) { valid_headers }

    # Test suite for GET /chatrooms/:chatroom_id/chats
    describe 'GET /chatrooms/:chatroom_id/chats' do
        before { get "/chatrooms/#{chatroom_id}/chats", headers: headers }

        context 'when chatroom exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end

            it 'returns all chatroom chats' do
                expect(json.size).to eq(20)
            end
        end

        context 'when chatroom does not exist' do
            let(:chatroom_id) { 928 }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Chatroom/)
            end
        end
    end

    # Test suite for GET /chatrooms/:chatroom_id/chats/:id
    describe 'GET /chatrooms/:chatroom_id/chats/:id' do
        before { get "/chatrooms/#{chatroom_id}/chats/#{id}", headers: headers }

        context 'when chatroom chat exists' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end

            it 'returns the chat' do
                expect(json['id']).to eq(id)
            end
        end

        context 'when chatroom chat does not exist' do
            let(:id) { 0 }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found chat' do
                expect(response.body).to match(/Couldn't find Chat/)
            end
        end
    end

    # Test suite for POST /chatrooms/:chatroom_id/chats
    describe 'POST /chatrooms/:chatroom_id/chats' do
        let(:valid_attributes) { { message: 'Visit Narnia', user_id: user_id.to_s, chatroom_id: chatroom_id.to_s }.to_json }

        context 'when request attributes are valid' do
            before { post "/chatrooms/#{chatroom_id}/chats", params: valid_attributes, headers: headers }

            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when an invalid request' do
            before { post "/chatrooms/#{chatroom_id}/chats", params: {}, headers: headers }

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a failure message' do
                expect(response.body).to match(/Validation failed: User must exist, Message can't be blank/)
            end
        end
    end

    # Test suite for PUT /chatrooms/:chatroom_id/chats/:id
    describe 'PUT /chatrooms/:chatroom_id/chats/:id' do
        let(:valid_attributes) { { message: 'Mozart', user_id: user_id.to_s }.to_json }

        before { put "/chatrooms/#{chatroom_id}/chats/#{id}", params: valid_attributes, headers: headers }

        context 'when chat exists' do
            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end

            it 'updates the chat' do
                updated_chat = Chat.find(id)
                expect(updated_chat.message).to match(/Mozart/)
            end
        end

        context 'when the chat does not exist' do
            let(:id) { 0 }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a not found message' do
                expect(response.body).to match(/Couldn't find Chat/)
            end
        end
    end

    # Test suite for DELETE /chatrooms/:id/chats/:id
    describe 'DELETE /chatrooms/:id' do
        before { delete "/chatrooms/#{chatroom_id}/chats/#{id}", headers: headers }

        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end
    end
end