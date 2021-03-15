class ArticlesController < ApplicationController
  before_action :article_finder, only: [:edit, :show, :update, :destroy]
  def show
  end
  
  def index
    @article = Article.all
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:notice] = "Added Successfully"
      redirect_to article_path(@article)
    else
      render 'new'
    end

  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Updated successfully"
      redirect_to article_path(@article)
    else
      render 'edit'
    end

  end

  def destroy
    #binding.pry
    @article.destroy
    flash[:notice]="Article was deleted successfully"
    redirect_to articles_path
  end
  private
    def article_finder
      @article = Article.find(params[:id])
    end
    def article_params
      params.require(:article).permit(:title, :description)
    end
end
