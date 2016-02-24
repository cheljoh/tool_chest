class ToolsController < ApplicationController

  def index
    # @tools = Tool.all
    user = current_user
    if user.nil?
      render :text => "There are no tools"
    else
      @tools = user.tools.all
      last_tool = current_user.tools.order(:created_at).last
      session[:most_recent_tool_id] = last_tool
      render 'index'
    end
  end

  def show
    user = current_user
    @tool = user.tools.find(params[:id])
    # @tool = Tool.find(params[:id])
  end

  def new
    user = current_user
    @tool = user.tools.new
    # @tool = Tool.new
  end

  def create
    user = current_user
    @tool = user.tools.new(tool_params)
    # @tool = Tool.new(tool_params)
    if @tool.save #if passed, do... save checks validations to see if it can be created
      flash[:notice] = "You created a tool!"
      redirect_to tool_path(@tool.id) #redirect to @tool will work, but nice to be more explicit
    else
      flash[:error] = @tool.errors.full_messages.join(", ")
      render :new #render does not make new request
    end
    #generate new, add attributes to tool, save tool, if saves in the db, will send user to view tool, no save then render new view
  end

  def edit
    user = current_user
    @tool = user.tools.find(params[:id])
    # @tool = Tool.find(params[:id])
  end

  def update
    user = current_user
    # @tool = Tool.find(params[:id])
    @tool = user.tools.find(params[:id])
    if @tool.update(tool_params)
      redirect_to tool_path(@tool.id)
    else
      render :edit
    end
  end

  def destroy
    user = current_user
    @tool = user.tools.find(params[:id]) #same as Tool.destroy(params[:id])
    @tool.destroy #activerecord method
    redirect_to tools_path
  end

  private

  def tool_params #more secure
    params.require(:tool).permit(:name, :quantity, :price) #tool key, only let specific attributes be changes
    #allows things from params into object
  end



end
