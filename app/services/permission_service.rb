class PermissionService
  attr_reader :user, :controller, :action

  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller, action)
    @controller = controller
    @action = action

    if user && user.business_admin?
      business_admin_permissions
    elsif user.registered_user?
      registered_user_permissions
    else
      guest_user_permissions
    end
  end

  private

  def platform_admin_permissions

  end

  def business_admin_permissions
    registered_user_permissions
  end

  def registered_user_permissions
    return true if controller == 'listings' && action.in?(%w(new create))
    guest_user_permissions
  end

  def guest_user_permissions
    return true if controller == 'welcome' && action == 'index'
  end
end
