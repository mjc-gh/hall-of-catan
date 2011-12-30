class GamesController < ApplicationController
  before_filter :find_game, :except =>  [:index, :new, :create]
  before_filter :load_locations_and_players, :only => [:new, :create, :edit, :update]
  
  def index
    @games = Game.recent.paginate(:page => params[:page])
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
    if @game.update_attributes(params[:game])
      if params[:game] && params[:game][:player_ids]
        player_ids = params[:game][:player_ids].collect { |id| id.to_i }
      
        @game.matches.each do |match|
          match.update_attribute(:position, player_ids.index(match.player_id))
        end
      end
    end
    
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
    @players = Player.by_name
    @locations = Location.by_name
  end
end
