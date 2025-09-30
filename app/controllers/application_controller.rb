class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :firstname_kanji, :lastname_kanji, :firstname_katakana, :lastname_katakana, :birth_date])
  end
end
