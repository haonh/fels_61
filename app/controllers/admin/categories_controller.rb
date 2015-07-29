class Admin::CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :admin_user 
  before_action :init_category, except: [:new, :index, :create]

  def index
    @categories = Category.ordered_by_create_at.paginate page: params[:page], per_page: Settings.per_page
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      respond_to do |format|
        format.html do
          flash[:success] = t "create_category_success_message"
          redirect_to admin_categories_path
        end
        format.js
      end
    else
      flash[:success] = t "create_category_failed_message"
      render :index
    end
  end
  
  def destroy
    if @category.destroy
      respond_to do |format|
        format.html do
          flash[:success] = t "destroy_category_success_message"
          redirect_to admin_categories_path
        end
        format.js
      end
    else
      flash[:success] = t "destroy_category_unsuccess_message"
      redirect_to admin_categories_path
    end
  end

  private
  def init_category
    @category = Category.find params[:id]
  end

  def category_params
    params.require(:category).permit :name, :description
  end
end
