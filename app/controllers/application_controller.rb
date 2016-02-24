class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  helper_method :most_recent_tool, :current_tool_summary, :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # def most_recent_tool
  #   last_tool = Tool.order(:created_at).last
  #   session[:most_recent_tool_id] = last_tool
  # end

  def current_tool_summary
    all_tools = Tool.all.count
    session[:current_tool_count] = all_tools
    sum_of_price = Tool.sum(:price)
    session[:current_potential_revenue] = sum_of_price
    "Tool count-#{session[:current_tool_count]} Potential revenue-#{session[:current_potential_revenue]}"
  end
end
