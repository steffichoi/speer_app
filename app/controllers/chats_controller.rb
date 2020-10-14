class ChatsController < ApplicationController
    before_action :set_chatroom
    before_action :set_chatroom_chat, only: [:show, :update, :destroy]
  
    # GET /chatrooms/:chatroom_id/chats
    def index
        json_response(@chatroom.chats)
    end
  
    # GET /chatrooms/:chatroom_id/chats/:id
    def show
        json_response(@chat)
    end
  
    # POST /chatrooms/:chatroom_id/chats
    def create
        @chat = @chatroom.chats.create!(chat_params)
        json_response(@chat, :created)
    end
  
    # PUT /chatrooms/:chatroom_id/chats/:id
    def update
        @chat.update(chat_params)
        head :no_content
    end
  
    # DELETE /chatrooms/:chatroom_id/chats/:id
    def destroy
        @chat.destroy
        head :no_content
    end
  
    private
  
    def chat_params
        params.permit(:message, :chatroom_id, :user_id)
    end
  
    def set_chatroom
        @chatroom = Chatroom.find(params[:chatroom_id])
    end
  
    def set_chatroom_chat
        @chat = @chatroom.chats.find_by!(id: params[:id]) if @chatroom
    end
end
