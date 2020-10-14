class TweetsController < ApplicationController
    before_action :set_todo, only: [:show, :update, :destroy]
  
    # GET /tweets
    def index
        @tweets = current_user.tweets
        json_response(@tweets)
    end
  
    # POST /tweets
    def create
        @tweets = current_user.tweets.create!(tweet_params)
        json_response(@tweets, :created)
    end

    # GET /tweets/:id
    def show
        json_response(@tweets)
    end
  
    # PUT /tweets/:id
    def update
        @tweets.update(tweet_params)
        head :no_content
    end
  
    # DELETE /tweets/:id
    def destroy
        @tweets.destroy
        head :no_content
    end
  
    private
  
    def tweet_params
        params.permit(:tweet)
    end
  
    def set_todo
        @tweets = Tweet.find(params[:id])
    end
end
