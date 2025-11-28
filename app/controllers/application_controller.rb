class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  skip_before_action :verify_authenticity_token
  before_action :set_search

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[image nickname firstname_kanji lastname_kanji firstname_katakana
                                               lastname_katakana birth_date])
  end

  def set_search
    @q = Item.ransack(params[:q])
    @items = @q.result.limit(5)
  end
end
