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

  def business_admin_permissions
    return true if controller == 'listings' && action.in?(%w(edit destroy update))
    return true if controller == 'users' && action.in?(%w(edit destroy))
    registered_user_permissions
  end

  def registered_user_permissions
    return true if controller == 'users' && action.in?(%w(show edit update))
    return true if controller == 'listings' && action.in?(%w(new create))
    return true if controller == 'reservations' && action.in?(%w(index show create))
    guest_user_permissions
  end

  def guest_user_permissions
    return true if controller == 'welcome' && action == 'index'
    return true if controller == 'carts' && action.in?(%w(show create))
    return true if controller == 'users' && action.in?(%w(new create))
    return true if controller == 'listings' && action.in?(%w(show search_results))
    return true if controller == 'sessions' && action.in?(%w(new create destroy))
    return true if controller == 'reservations' && action.in?(%w(new))
  end
end
