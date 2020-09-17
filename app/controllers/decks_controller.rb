class DecksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def new
    @deck = current_user.decks.build
  end
  
  def create
    @deck = current_user.decks.build(deck_params)
    if @deck.save then
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
    wins = @deck.number_of_wins.to_i
    use = @deck.number_of_use.to_i
    if (wins == 0) || (use == 0) then
      @rate = 0
    elsif wins && use then
      @rate = wins.to_f / use.to_f * 100
    end
  end
  
  def edit
    @deck = current_user.decks.find_by(id: params[:id])
  end
  
  def update
    @deck = current_user.decks.find_by(id: params[:id])
    oldname = @deck.name
    oldimagefile_name = @deck.imagefile_name
    oldcomment = @deck.comment
    oldnumber_of_wins = @deck.number_of_wins.to_i
    oldnumber_of_use = @deck.number_of_use.to_i
    oldrate = oldnumber_of_wins.to_f / oldnumber_of_use.to_f * 100
    if @deck.update(deck_params) then
      if @deck.number_of_wins == oldnumber_of_wins.to_s && @deck.number_of_use == oldnumber_of_use.to_s
        if @deck.name == oldname && @deck.imagefile_name == oldimagefile_name && @deck.comment == oldcomment
          flash[:success] = '何も更新されませんでした。'
          redirect_to deck_path
        else
          flash[:success] = 'デッキ編集が完了しました。'
          redirect_to deck_path
        end
      else
        if @deck.number_of_wins.to_i < 0 || @deck.number_of_use.to_i < 0 then
          flash.now[:danger] = '正数を入力してください。'
          @deck.number_of_wins = oldnumber_of_wins.to_i
          @deck.number_of_use = oldnumber_of_use.to_i
          if (oldnumber_of_wins == 0) || (oldnumber_of_use == 0) then
            @deck.save
            @rate = 0
          else
            @deck.save
            @rate = oldrate
          end
          render action: :show
        elsif @deck.number_of_wins.to_i <= @deck.number_of_use.to_i then
          flash[:success] = '勝率を計算しました。'
          redirect_to deck_path
        elsif @deck.number_of_wins.to_i > @deck.number_of_use.to_i then
          flash.now[:danger] = '勝利回数は使用回数以下になるように入力してください。'
          @deck.number_of_wins = oldnumber_of_wins.to_i
          @deck.number_of_use = oldnumber_of_use.to_i
          if (oldnumber_of_wins == 0) || (oldnumber_of_use == 0) then
            @deck.save
            @rate = 0
          else
            @deck.save
            @rate = oldrate
          end
          render action: :show
        end
      end
    else
      if @deck.number_of_wins=="" || @deck.number_of_use=="" then 
        flash.now[:danger] = '数値を入力してください。'
          @deck.number_of_wins = oldnumber_of_wins.to_i
          @deck.number_of_use = oldnumber_of_use.to_i
          if (oldnumber_of_wins == 0) || (oldnumber_of_use == 0) then
            @rate = 0
          else
            @rate = oldrate
          end
        render action: :show
      elsif @deck.name == "" || @deck.comment == "" || @deck.name.length > 15 || @deck.comment.length > 255 then 
        flash.now[:danger] = 'デッキ編集に失敗しました。'
        render action: :edit
      elsif @deck.number_of_wins.to_i != /^[0-9]+$/ || @deck.number_of_use.to_i != /^[0-9]+$/ then
        flash.now[:danger] = '小数点と文字は入力しないでください。'
          @deck.number_of_wins = oldnumber_of_wins.to_i
          @deck.number_of_use = oldnumber_of_use.to_i
          if (oldnumber_of_wins == 0) || (oldnumber_of_use == 0) then
            @rate = 0
          else
            @rate = oldrate
          end
        render action: :show
      end
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
      flash[:danger] = "権限がありません"
      redirect_to root_url
    end
  end
  
end