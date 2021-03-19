class ArticlesController < ApplicationController
  before_action :article_finder, only: [:edit, :show, :update, :destroy]
  before_action :require_user
  before_action :require_same_user, only: [:update, :edit, :destroy]

  def show
  end
  
  def index
    @articles = Article.paginate(page: params[:page], per_page: 3)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:success] = "Added Successfully"
      redirect_to article_path(@article)
    else
      render 'new'
    end

  end

  def edit
  end

  def update
    if @article.update(article_params)
      flash[:success] = "Updated successfully"
      redirect_to article_path(@article)
    else
      render 'edit'
    end

  end

  def destroy
    #binding.pry
    @article.destroy
    flash[:danger]="Article was deleted successfully"
    redirect_to articles_path
  end
  private
    def article_finder
      @article = Article.find(params[:id])
    end
    def article_params
      params.require(:article).permit(:title, :description)
    end

    def require_same_user
      if current_user!= @article.user and !current_user.admin?
        flash[:danger] = "You don't have rights to do this"
        redirect_to root_path
      end
    end
end
