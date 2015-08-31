class PermissionService
  attr_reader :user, :controller, :action

  def initialize(user)
    @user = user || User.new
  end

  def allow?(controller, action)
    @controller = controller
    @action = action
    if user.business_admin?
      business_admin_permissions
    elsif user.registered_user?
      registered_user_persmissions
    else
      guest_user_permissions
    end
    # return true if controller == 'listing' && action == 'index'
  end

  private

  def business_admin_permissions

  end

  def registered_user_permissions

  end

  def guest_user_permissions

  end
end
