# This is the AdminController class.
class AdminController < ApplicationController
  before_action :authenticate_admin!

  def index; end
end
