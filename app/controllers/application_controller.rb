class ApplicationController < ActionController::Base

  private
    def not_authenticated
      redirect_to login_url
    end
end
