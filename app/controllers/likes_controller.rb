class LikesController < ApplicationController

  def create
    Rails::logger.info("-------#{params}------------")
    @article = Article.find(params[:article_id])
    current_user.likes.create(article_id: @article.id)
    render :like
  end

  def destroy
    Rails::logger.info("-------#{params}------------")
    like = Like.find(params[:id])
    @article = like.article
    like.destroy
    render :like
  end

end
