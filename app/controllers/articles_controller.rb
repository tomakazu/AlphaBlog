class ArticlesController < ApplicationController

    before_action :set_article, only: [:destroy, :show, :edit, :update]

    def show
    end

    def index 
        @articles = Article.all
    end

    def new
       @article = Article.new 
    end

    def create
        @article = Article.new(params.require(:article).permit(:title,:description))
        @article.user_id = User.first.id
        if @article.save
         flash[:notice] = "Article was successfull saved!"   
         redirect_to @article
        else
         render 'new'
        end    
    end

    def edit
    end

    def update
        if @article.update(params.require(:article).permit(:title,:description))
            flash[:notice] = "Article was successfully updated!"
            redirect_to @article
        else    
            render 'edit'
        end
    end

    def destroy
        @article.destroy
        redirect_to articles_path
    end

    private
        def set_article
            @article = Article.find(params[:id])
        end
end