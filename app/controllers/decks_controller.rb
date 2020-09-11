class DecksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:update, :destroy]
  
  def new
    @deck = current_user.decks.build
  end
  
  def create
    @deck = current_user.decks.build(deck_params)
    if @deck.save
      flash[:success] = 'デッキを登録しました。'
      redirect_to root_url
    else
      @decks = current_user.decks.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'デッキの登録に失敗しました。'
      render new_deck_path
    end
  end
  
  def show
    @deck = current_user.decks.find_by(id: params[:id])
    @favorite = current_user.favorites.new
    if @deck.number_of_wins && @deck.number_of_use
      wins = @deck.number_of_wins.to_i
      use = @deck.number_of_use.to_i
      @rate = wins.to_f / use.to_f
    else
      @rate = 0
    end
  end
  
  def edit
    @deck = current_user.decks.find_by(id: params[:id])
  end
  
  def update
    @deck = current_user.decks.find_by(id: params[:id])
    if @deck.update(deck_params)
      flash[:success] = 'デッキ編集が完了しました'
      redirect_to deck_path
    else
      flash.now[:danger] = 'デッキ編集に失敗しました'
      render edit_deck_path
    end
  end
  
  
  def destroy
    @deck = current_user.decks.find_by(id: params[:id])
    @deck.destroy
    
    flash[:success] = 'デッキは正常に削除されました'
    redirect_to root_url
  end
  
  def deck_params
    params.require(:deck).permit(:name, :imagefile_name, :comment, :number_of_use, :number_of_wins)
  end
  
  def correct_user
    @deck = current_user.decks.find_by(id: params[:id])
    unless @deck
      redirect_to root_url
    end
  end
  
end