class ArticlesController < ApplicationController
  before_action :authenticate_user!

  after_action :verify_authorized, :except => :index, unless: :devise_controller?
  after_action :verify_policy_scoped, :only => :index, unless: :devise_controller?


  def index
    @articles = policy_scope(Article)
  end

  def show
    @article = Article.find(params[:id])
    authorize @article
  end

  def new
    user_signed_in?
    @article = Article.new
    authorize @article
  end

  def edit
    user_signed_in?
    @article = Article.find(params[:id])
    authorize @article
  end

  def create
    user_signed_in?
    @article = Article.new(article_params)
    authorize @article

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    user_signed_in?
    @article = Article.find(params[:id])
    authorize @article

    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    user_signed_in?
    @article = Article.find(params[:id])
    authorize @article
    @article.destroy

    redirect_to articles_path
  end

  private
    def article_params
      params.require(:article).permit(:title, :text)
    end
end
