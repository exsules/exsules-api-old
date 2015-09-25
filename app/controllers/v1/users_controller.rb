module V1
  class UsersController < ApplicationController
    before_action :doorkeeper_authorize!

    def me
      if current_resource_owner
        render json: current_resource_owner, status: 200
      end
    end
  end
end