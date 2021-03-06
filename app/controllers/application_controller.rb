# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_locale, :set_content_language_header
  before_action :set_raven_context, if: -> { Rails.env.production? }

  def default_url_options
    { locale: I18n.locale }
  end

  private

  def set_raven_context
    Raven.user_context(id: current_administrator&.id)
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end

  def set_locale
    I18n.locale = I18n.locale_available?(locale_param.try(:to_sym)) ? locale_param : I18n.default_locale
  end

  def locale_param
    params[:locale]
  end

  def set_content_language_header
    response.headers['Content-Language'] = I18n.available_locales.join(',')
  end
end
