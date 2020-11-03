class ArticlesController < ApplicationController
  before_action :authenticate_user!


  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    user_signed_in?
    @article = Article.new
  end

  def edit
    user_signed_in?
    @article = Article.find(params[:id])
  end

  def create
    user_signed_in?
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    user_signed_in?
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    user_signed_in?
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end
end
