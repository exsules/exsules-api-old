module V1
  class ProfilesController < ApplicationController
    before_action :doorkeeper_authorize!

    def show
      profile = Profile.friendly.find(params[:handle])

      render json: profile
    end

    def index
      profiles = Profile.all

      render json: profiles
    end
  end
end