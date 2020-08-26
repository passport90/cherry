class ApplicationController < ActionController::Base
  def index
    @disable_nav = true
  end
end
