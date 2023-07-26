class SessionsController < ApplicationController
  def destroy
    sign_out(current_user)
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove('logout-frame') }
      format.html { redirect_to root_path, notice: 'Logged out successfully.' }
    end
  end
end
