module V1
  class ProfilesController < ApplicationController
    before_action :doorkeeper_authorize!

    def show
      profile = Profile.find(params[:id])

      render json: profile
    end
  end
end