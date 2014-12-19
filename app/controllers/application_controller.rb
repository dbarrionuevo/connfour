class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def player_1
    @player_1 ||= User.find(1)
  end
  helper_method :player_1

  def player_2
    @player_2 ||= User.find(2)
  end
  helper_method :player_2

  def current_user
    params[:user_id].to_i == 1 ? player_1 : player_2
  end
  helper_method :current_user

end
