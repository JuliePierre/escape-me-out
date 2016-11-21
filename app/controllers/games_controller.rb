class GamesController < ApplicationController
  def index
    if params[:search]
      if params[:players]
        @games = Game.where("min_players > ? AND max_players < ?", params[:players], params[:players]).where("name LIKE ? OR address LIKE ?", params[:search], "%#{params[:search]}%")
      else
        @games = Game.where("name LIKE ? OR address LIKE ?", params[:search], "%#{params[:search]}%")
      end
    elsif params[:players]
      @games = Game.where("min_players > ? AND max_players < ?", params[:players], params[:players])
    else
      @games = Game.all
   end
  end
end
