class CategoriesController < ApplicationController
    
    before_action :require_admin, only: [:new, :create]

    def show
        @category = Category.find(params[:id])
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

    private
    def set_params
        params.require(:category).permit(:name)
    end

    def require_admin
        if !(logged_in? and current_user.admin)
            flash[:alert] = "Only admins can perform the action"
            redirect_to categories_url
        end
    end


end
