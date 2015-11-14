class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :validate_user, only: [:update, :destory]

  # GET /articles
  # GET /articles.json

  def index
    @user = User.find(params[:user_id])
    @articles = @user.articles.page params[:page]
    respond_to do |format|
      format.html { render :index }
      format.js
    end
  end

  def autocomplete
    @articles = Article.find_by(id: params[:article_id])
    term = params[:term].split(/@(\w+)$/).last
    logger.info("-----------term::::#{term}")
    @commentor_names = @articles.comments.map{|e| e.name if e.name.match(/^#{term}/i) }.compact.uniq
    logger.info("-----------hahahahha::::#{@commentor_names}")
    respond_to do |format|
      format.html
      format.json {
        render json: @commentor_names
      }
    end
  end

  def home
    if params[:search]
      @all_articles = Article.search(params[:search]).page params[:page]
    elsif params[:category]
      @all_articles = Article.where(category: params[:category]).page params[:page]
    else
      @all_articles = Article.all.page params[:page]
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article.inc(view_count: 1)
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
    # @article.destroy
    @article.soft_destroy
    respond_to do |format|
      format.html { redirect_to user_articles_path, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def favorite
    Rails::logger.info("－－－－－－－－－－#{params}－－－－－－－－－－－－－－－")
      @article = Article.find(params[:id])
      @article.favorites.create(user_id: current_user.id)
      render :favorite
  end

  def unfavorite
    @article = Article.find(params[:id])
    favorite = Favorite.where(user_id: current_user.id, article_id: @article.id).first
    favorite.destroy
    render :favorite
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