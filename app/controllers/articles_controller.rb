class ArticlesController < ApplicationController
  def show
    @article= Article.find(params[:id])
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

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
