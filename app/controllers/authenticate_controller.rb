class AuthenticateController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_admin
  before_action :build_menu

  private

  def build_menu
    if current_user.has_role? :dashboard
      @menu = Menu.all.slice!('/reports/orders','/tasks','/materials', '/histories','/welcome')
      unless current_user.has_role? :admin
        @menu = @menu.slice!('/admin/users','/admin/roles')
      end
    else
      @menu = Menu.all.delete_if{| key, value | (key != '/clients') && (key != '/reports') }
    end
  end

  def verify_admin
    redirect_to root_url unless current_user.has_role? :access
  end

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to dashboard_url, alert: exception.message}
    end
  end
end
