class Admin::CategoriesController < Admin::BaseController

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_category_path(@category)
    else
      render :new
    end
  end

  def show
    @category = Category.find(params[:id])
    @category_tools = @category.tools
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update #this actually is being called, using new. need to fix
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect to admin_category_path(@category)
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    redirect_to admin_categories_path
  end

private

  def category_params
    params.require(:category).permit(:name)
  end

end
