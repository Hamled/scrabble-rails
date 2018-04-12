class PlayersController < ApplicationController
  def show
    @player = Player.find(params[:player_id] || params[:id])
  end

  def play
    player = Player.find(params[:player_id] || params[:id])
    tile_bag = TileBag.last


    # This may fail if word cannot be played, so we use
    # ensure to always redirect to the player page
    ApplicationRecord.transaction do
      player.play!(params[:word])
      player.draw_tiles!(tile_bag)
    end
  ensure
    redirect_to player
  end
end
