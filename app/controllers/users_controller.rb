class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.includes(:posts).all

    head :not_found unless @users
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render xml: @users }
      format.json { render json: @users }
    end
  end

  def show
    @user = User.find(params[:id])
  end
end
