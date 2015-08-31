class LikesController < ApplicationController

  def create
    @article = Article.find(params[:article_id])
    current_user.likes.create(article_id: @article.id)
    render :like
  end

  def destroy
    like = Like.find(params[:id])
    @article = like.article
    like.destroy
    render :like
  end

end
