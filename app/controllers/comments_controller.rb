class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def show
    @commentor_names = @article.comments.map(&:name).uniq
    respond_to do |format|
      format.html
      format.json { render :json => @article }
    end
  end

  def edit
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create!(comment_params.merge(name: current_user.user_name,
                                                              floor: @article.comments.unscoped.count + 1))
    render :show
  end

  def update
    if @comment.update(comment_params)
      redirect_to user_article_path(@article.user, @article)
    else
      render :edit
    end
  end

  def destroy
    Rails::logger.info("----------软删除－－－－－－－－－－")
    @comment.soft_destroy
    respond_to do |format|
      format.html { redirect_to user_article_path(@article.user, @article), notice: 'comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def set_comment
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:name, :content)
  end

end