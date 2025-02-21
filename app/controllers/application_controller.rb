class ApplicationController < ActionController::Base
  rescue_from StandardError, with: :handle_error

  private

  def handle_error(exception)
    if Rails.env.development?
      render plain: "An error occurred. Please try again.", status: 500
    else
      raise exception # Re-raise the exception in other environments
    end
  end
end
