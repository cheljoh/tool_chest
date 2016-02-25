class Admin::BaseController < ApplicationController
  before_action :require_admin #will run each time

   def require_admin #this is our authorization
     render file: '/public/404' unless current_admin?
   end

end
