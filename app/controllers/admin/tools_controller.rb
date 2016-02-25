class Admin::ToolsController < Admin::BaseController

  def index
    @tools = Tool.all
    last_tool = current_user.tools.order(:created_at).last
    session[:most_recent_tool_id] = last_tool
    render 'index'
  end

  def show
    @tool = Tool.find(params[:id])
  end

  def new
    @tool = Tool.new
  end

  def create
    @tool = Tool.new(tool_params)
    if @tool.save #if passed, do... save checks validations to see if it can be created
      flash[:notice] = "You created a tool!"
      redirect_to admin_tool_path(@tool.id) #redirect to @tool will work, but nice to be more explicit
    else
      flash[:error] = @tool.errors.full_messages.join(", ")
      render :new #render does not make new request
    end
    #generate new, add attributes to tool, save tool, if saves in the db, will send user to view tool, no save then render new view
  end

  def edit
    @tool = Tool.find(params[:id])
  end

  def update
    @tool = Tool.find(params[:id])
    if @tool.update(tool_params)
      redirect_to admin_tool_path(@tool.id)
    else
      render :edit
    end
  end

  def destroy
    @tool = Tool.find(params[:id]) 
    @tool.destroy
    redirect_to admin_tools_path
  end

  private

  def tool_params #more secure
    params.require(:tool).permit(:name, :quantity, :price, :category_id) #tool key, only let specific attributes be changes
    #allows things from params into object
  end

end
