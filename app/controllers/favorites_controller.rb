class FavoritesController < ApplicationController

  def create
    Rails::logger.info("－－－－－－－－－－#{params}－－－－－－－－－－－－－－－")
    @article = Article.find(params[:article_id])
    current_user.favorites.create(article_id: params[:article_id])
    render :favorite
  end

  def destroy
    Rails::logger.info("－－－－－－－－－－#{params}－－－－－－－－－－－－－－－")
    favorite = Favorite.find(params[:id])
    Rails::logger.info("－－－－－－－－－－#{favorite}－－－－－－－－－－－－－－－")
    @article = favorite.article
    favorite.destroy
    render :favorite
  end

end