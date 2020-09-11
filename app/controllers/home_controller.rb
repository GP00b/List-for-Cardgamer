class HomeController < ApplicationController
  def index
    if logged_in?
      @decks = current_user.decks.order(id: :desc).page(params[:page]).per(10)
    end
  end

end
