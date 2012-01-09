class PlayersController < ApplicationController
  before_filter :find_player, :except =>  [:index, :new, :create]
  
  def index
    @players = Player.by_name
    respond_with @players
  end

  def show
    @games = @player.games.recent.paginate(:page => params[:page])
    
    respond_with @player
  end

  def new
    @player = Player.new
    respond_with @player
  end
  
  def create
    @player = Player.create(params[:player])
    respond_with @player
  end

  def edit
    respond_with @player
  end
  
  def update
    @player.update_attributes(params[:player])
    respond_with @player
  end
  
  # TODO deal with data-deps
  # def destroy
  #   @player.destroy
  #   respond_with @player
  # end

  protected
  
  def find_player
    @player = Player.find(params[:id])
  end
end
