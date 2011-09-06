class ApplicationController < ActionController::Base
  protect_from_forgery
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to root_url
  end
def redirect_to(options = {}, response_status = {})
  if request.xhr?
    render(:update) {|page| page.redirect_to(options)}
  else
    super(options, response_status)
  end
end
end
