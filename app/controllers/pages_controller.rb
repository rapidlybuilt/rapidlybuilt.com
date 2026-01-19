class PagesController < ApplicationController
  def forbidden
    render status: :forbidden
  end

  def not_found
    respond_to do |format|
      format.html { render status: :not_found }
      format.all { head :not_found }
    end
  end

  def internal_server_error
    render status: :internal_server_error
  end
end
