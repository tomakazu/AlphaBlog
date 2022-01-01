class UsersController < ApplicationController

    def show
        @user = User.find(params[:id])
        @articles = @user.articles
    end
        
    def new
        @user = User.new
    end

    def index
        @users = User.all
    end

    def create
        @user = User.new(set_params)
        if @user.save
            flash[:notice] = "You have successfully signed up! Welcome to Alpha Blog"
            redirect_to @user
        else
            render 'new'
        end
    end

    def edit
        @user = User.find(params[:id])
    end    

    def update
        @user = User.find(params[:id])
        if @user.update(set_params)
            flash[:notice] = "Your profile is successfully updated!"
            redirect_to @user
        else
            render 'new'
        end
    end

    private
    
    def set_params
        params.require(:user).permit(:password, :username, :email)
    end
end