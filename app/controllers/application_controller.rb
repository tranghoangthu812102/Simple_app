class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :set_locale
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_rescue

  private
  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    check = I18n.available_locales.include?(locale)
    I18n.locale = check ? locale : I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def record_not_found_rescue
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end
end
