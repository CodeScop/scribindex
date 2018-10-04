class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_project
  helper_method :current_story

  def current_project
  	if !session[:project_id].nil?
  		Project.find(session[:project_id])
  	end
  end

  def current_story
    if !session[:story_id].nil?
      Story.find(session[:story_id])
    end 
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :role])

    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :role])
  end
end
