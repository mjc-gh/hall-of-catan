class GamesController < ApplicationController
  before_filter :find_game, :except =>  [:index, :new, :create]
  before_filter :load_locations_and_players, :only => [:new, :create, :edit, :update]
  
  def index
    @games = Game.all
    respond_with @games
  end

  def show
    respond_with @game
  end

  def new
    @game = Game.new
    respond_with @game
  end
  
  def create
    @game = Game.create(params[:game])
    respond_with @game
  end

  def edit
    respond_with @game
  end
  
  def update
    @game.update_attributes(params[:game])
    respond_with @game
  end
  
  # TODO deal with data-deps
  # def destroy
  #   @game.destroy
  #   respond_with @game
  # end

  protected
  
  def find_game
    @game = Game.find(params[:id])
  end
  
  def load_locations_and_players
    @players = Player.all
    @locations = Location.all
  end
end
