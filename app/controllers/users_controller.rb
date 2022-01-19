class UsersController < ApplicationController

    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_action :set_params, only: [:update, :create]
    before_action :require_user, only: [:edit, :update, :destroy]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def show
        @articles = @user.articles.paginate(page: params[:page], per_page: 4)
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
            session[:user_id] = @user.id
            redirect_to @user
        else
            render 'new'
        end
    end

    def edit
    end    

    def update
        if @user.update(set_params)
            flash[:notice] = "Your profile is successfully updated!"
            redirect_to @user
        else
            render 'new'
        end
    end

    def destroy
        @user.destroy
        if !current_user.admin?
            session[:user_id] = nil
        end    
        flash[:notice] = "Account and all associated articles are deleted"
        redirect_to root_path
    end

    private
    
    def set_params
        params.require(:user).permit(:password, :username, :email)
    end

    def set_user
        @user = User.find(params[:id])
    end

    def require_same_user
        if current_user != @user && !current_user.admin?
            flash[:alert] = "You can edit or delete your own profile only"
            redirect_to @user
        end
    end

end