class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :validate_user, only: [:update, :destory]

  # GET /articles
  # GET /articles.json
  def index
    @user = User.find(params[:user_id])
    @articles = @user.articles.page params[:page]
  end

  def home
    if params[:search]
      @all_articles = Article.search(params[:search]).page params[:page]
    else
      @all_articles = Article.all.page params[:page]
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    Rails::logger.info("----------------#{params[:user_id]}---------")
    @user = User.find(params[:user_id])
    @article = @user.articles.new
  end

  # GET /articles/1/edit
  def edit
    @article = @user.articles.find(params[:id])
  end

  # POST /articles
  # POST /articles.json
  def create
    @user = User.find(params[:user_id])
    Rails::logger.info("----------------#{article_params}---------")
    @article = @user.articles.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to user_article_path(@user, @article), notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to user_article_path(@user, @article), notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = @user.articles.find(params[:id])
    @article.destroy
    respond_to do |format|
      format.html { redirect_to user_articles_path, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      Rails::logger.info("----------------#{params}---------")
      @user = User.find(params[:user_id])
      @article = @user.articles.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:id, :title, :content, :category)
    end
end
