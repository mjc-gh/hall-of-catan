class HomeController < ApplicationController
  def index
    @games = Game.limit(5)
    respond_with @games
  end
end
