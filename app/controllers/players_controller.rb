class PlayersController < ApplicationController
  def show
    @player = Player.find(params[:player_id] || params[:id])
  end
end
