class ArticlesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def index
    @articles = policy_scope(Article)
  end

  def show
  end

  def new
    @article = Article.new
    authorize @article
  end

  def create
    @article = Article.new(article_params)
    authorize @article
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @article.update(article_params)
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
    authorize @article
  end

  def article_params
    params.require(:article).permit(:title, :text, :user_id)
  end
end
