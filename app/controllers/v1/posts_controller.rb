module V1
  class PostsController < ApplicationController
    before_action :doorkeeper_authorize!

    def show
      post = Post.find(params[:id])
      render json: post
    end
  end
end
