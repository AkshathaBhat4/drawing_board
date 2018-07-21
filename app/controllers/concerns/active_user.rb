module ActiveUser
  extend ActiveSupport::Concern
  included do
    before_action :active_user
  end

  def active_user
    if session[:user_id].blank?
      create_new_user
    else
      fetch_session_user
    end
  end

  private

  def create_new_user
    @user = User.create
    session[:user_id] = @user.id
  end

  def fetch_session_user
    @user = User.find_by_id session[:user_id]
  end
end
