class CategoriesController < ApplicationController
    
    before_action :require_admin, only: [:new, :create, :edit, :update]
    before_action :set_category, only: [:edit, :update, :show]

    def show
        @articles = @category.articles.paginate(page: params[:page], per_page: 4)
    end

    def new
        @category = Category.new
    end

    def index
        @categories = Category.paginate(page: params[:page], per_page: 5)
    end

    def create
        @category = Category.create(set_params)
        if @category.save
            redirect_to @category
        else
            render 'new'
        end
    end

    def edit
    end

    def update
        if @category.update(set_params)
            flash[:notice] = "Category updated successfully"
            redirect_to @category
        else
            render 'edit'
        end
    end

    def destroy
        
    end

    private
    def set_params
        params.require(:category).permit(:name)
    end

    def set_category
        @category = Category.find(params[:id])
    end
    def require_admin
        if !(logged_in? and current_user.admin)
            flash[:alert] = "Only admins can perform the action"
            redirect_to categories_url
        end
    end

end
