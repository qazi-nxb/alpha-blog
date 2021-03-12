class ArticlesController < ApplicationController
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.save
    redirect_to(@article)
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end
end