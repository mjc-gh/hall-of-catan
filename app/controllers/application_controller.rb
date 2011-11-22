require "application_responder"

class ApplicationController < ActionController::Base
  protect_from_forgery
  self.responder = ApplicationResponder

  respond_to :html, :mobile, :json, :xml
  
  before_filter :determine_format
  before_filter :access_required

  rescue_from ActiveRecord::RecordNotFound, :with => :render_not_found
  rescue_from ActionController::UnknownAction, :with => :render_not_found
  rescue_from ActionController::RoutingError, :with => :render_not_found
  
  def render_not_found
    render_error I18n.t('flash.alert.not_found'), 404
  end
  
  def render_error(msg, status = 400)
    resp = { :alert => msg }

    respond_to do |format|
      format.html { redirect_to root_url, :flash => resp }
      format.mobile { redirect_to root_url, :flash => resp }
      
      format.json { render :json => resp, :status => status }
      format.xml { render :xml => resp, :status => status }
    end
  end

  
  def determine_format
    request.format = :mobile if is_mobile?
  end
  
  def is_mobile?
    @is_mobile ||= params[:_mobile] == '1' || request.user_agent =~ /iPhone|iPad|android/
  end
  
  def has_access?
    !session[:has_access].nil?
  end
  
  def access_required
    if authenticate
      session[:has_access] = true
    else
      redirect_to root_url
    end
  end
  
  def authenticate
    authenticate_or_request_with_http_basic do |user, passwd|
      # TODO read from config
      user == 'admin' && passwd == 'catan'
    end
  end
  
  helper_method :has_access?
end
