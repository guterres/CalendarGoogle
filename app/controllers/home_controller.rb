class HomeController < ApplicationController
  before_action :confirm_logged_in, except: :logout

  def index
  end

  def auth
    redirect_to client.authorization_uri.to_s
  end

  def logout
    session[:authorization] = nil
    redirect_to home_url
  end

  def callback
    session[:authorization] = client.fetch_access_token!
    redirect_to events_url
  end

  private

  def client
    client_google = GoogleAPI.client
    client_google.redirect_uri = callback_url
    client_google.code = params[:code] if params[:code].present?
    client_google
  end

  def confirm_logged_in
    redirect_to events_url unless session[:authorization].nil?
  end
end
