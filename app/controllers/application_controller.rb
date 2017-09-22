class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :setup

  private

  def setup
    action = params[:action]
    controller = params[:controller].split('/')

    @title = action == 'index' ?  'List ' + controller.last.titleize : [action, controller.last.singularize].join(' ').titleize
    @title_section = controller.last.titleize
  end
end
