class ChatroomsController < ApplicationController
     before_action :set_chatroom, only: [:show, :update, :destroy]

    # GET /chatrooms
    def index
        @chatrooms = current_user.chatrooms
        json_response(@chatrooms)
    end

    # POST /chatrooms
    def create
        
        @chatroom = Chatroom.create!(chatroom_params)
        @chatroom.memberships.create!(chatroom_id: @chatroom[:id], user_id: current_user[:id])
        # @chatroom.memberships << Membership.find_all_by_id(user_ids)
        # chatroom_params[:user_ids].each do |memberships|
        #     memberships = Membership.create(chatroom_id: @chatroom[:id], user_id: memberships)
        # end

        json_response(@chatroom, :created)
    end

    # GET /chatrooms/:id
    def show
        json_response(@chatroom)
    end

    # PATCH/PUT /chatrooms/:id
    def update
        @chatroom.update(chatroom_params)
        head :no_content
    end

    # DELETE /chatrooms/:id
    def destroy
        @chatroom.destroy
        head :no_content
    end

    private

    def chatroom_params
        params.permit(:title, :created_by, user_ids: [])
    end

    def set_chatroom
        @chatroom = Chatroom.find(params[:id])
    end
end
