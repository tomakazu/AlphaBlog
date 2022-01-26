class CategoriesController < ApplicationController
    
    before_action :set_category, only: [:show]

    def show
        @category = Category.find(params[:id])
    end

    def new
        @category = Category.new
    end

    def index
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

end
