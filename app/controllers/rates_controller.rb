class RatesController < ApplicationController
  
  def create
    @rate = current_user.rates.build(rate_params)
    if @rate.update(rate_params)
      flash[:success] = 'デッキ勝率計算が完了しました'
      redirect_to deck_path
    else
      flash.now[:danger] = 'デッキ勝率計算に失敗しました'
      render deck_path
    end
  end
  
  def rate_params
    params.require(:rate).permit(:number_of_use, :number_of_wins)
  end
  
  def correct_user
    @rate = current_user.rates.find_by(id: params[:id])
    unless @rate
      redirect_to root_url
    end
  end
end
