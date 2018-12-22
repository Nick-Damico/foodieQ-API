module UserHelper
  def current_user?(user)
    current_user == user
  end

  def log_out(user)
    sign_out(@user)
    current_user = nil
  end
end
