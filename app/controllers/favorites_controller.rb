class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  
  def index
    @favorites = Favorite.all.page(params[:page]).per(10)
  end
  
  def create
    @favorite = Favorite.new(user_id: current_user.id, deck_id: params[:deck_id])
    @favorite.save
    flash[:success] = 'デッキをお気に入り登録しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @favorite = Favorite.find_by(user_id: current_user.id, deck_id: params[:deck_id])
    @favorite.destroy
    flash[:success] = 'デッキのお気に入りを解除しました。'
    redirect_back(fallback_location: root_path)
  end
  
end