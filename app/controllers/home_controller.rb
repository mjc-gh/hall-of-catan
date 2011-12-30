class HomeController < ApplicationController
  def index
    @games = Game.recent.limit(5)
    respond_with @games
  end
end
