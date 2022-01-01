class UsersController < ApplicationController

    def show
        @user = User.find(params[:id])
        @articles = @user.articles
    end
        
    def new
        @user = User.new
    end

    def create
        @user = User.new(params.require(:user).permit(:password, :username, :email))
        if @user.save
            flash[:notice] = "You have successfully signed up! Welcome to Alpha Blog"
            redirect_to articles_path
        else
            render 'new'
        end
    end

    def edit
        @user = User.find(params[:id])
    end    

    def update
        @user = User.find(params[:id])
        if @user.update(params.require(:user).permit(:password, :username, :email))
            flash[:notice] = "Your profile is successfully updated!"
            redirect_to articles_path
        else
            render 'new'
        end
    end
end