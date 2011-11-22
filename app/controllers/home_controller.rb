class HomeController < ApplicationController
  def index
    @games = Game.limit(5)
  end
end
