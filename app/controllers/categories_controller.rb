class CategoriesController < ApplicationController
    before_action :require_admin, except: [:index, :show]
    before_action :require_category, only: [:edit, :update, :show]
    
    def index
        @categories = Category.paginate(page: params[:page], per_page: 5)
    end
    
    def new
        @category = Category.new()
    end
    
    def create
        @category = Category.new(category_params)
        if @category.save()
            flash[:success] = "New category was created successfully"
            redirect_to categories_path
        else
            render 'new'
        end
    end
    
    def edit
    end
    
    def update
        if @category.update(category_params)
            flash[:success] = "Category #{@category.name} was succesfully updated"
            redirect_to category_path(@category)
        else
            flash[:danger] = "Category cannot be updated"
            redirect_to categories_path            
        end
    end
    
    def show
        @category_articles = @category.articles.paginate(page: params[:page], per_page: 5)
    end
    
    private
    def category_params
        params.require(:category).permit(:name)
    end
    
    def require_category
        @category = Category.find(params[:id])
    end
    
    def require_admin
        if !logged_in? || (logged_in? && !current_user.admin?)
            flash[:danger] = "Only admin can perform this action"
            redirect_to categories_path
        end
    end
end