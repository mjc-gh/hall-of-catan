require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  setup do
    grant_access!
  end
  
  teardown do
    mocha_teardown
  end
  
  test "new" do
    get :new
    
    assert_response :success
    assert assigns(:game)
  end
  
  test "create" do
    player_ids = 4.times.collect { |n| create(:player).id }
    data = {
      :location_id => create(:location).id,
      :player_ids => player_ids,
      :winner_id => player_ids[1]
    }
    
    post :create, :game => attributes_for(:game, data)
    
    assert assigns(:game)
    game = assigns(:game).reload
    
    4.times.each { |n| assert_equal player_ids[n], game.players[n].id }
    
    assert_redirected_to game_url(game)
    assert flash[:notice]
  end
  
  test "create invalid" do
    post :create
    
    assert_template :new
    assert assigns(:game)
  end
  
  test "index" do
    get :index
    
    assert_response :success
    assert_template :index
    assert assigns(:games)
  end
  
  test "show" do
    game = create(:game)
    get :show, :id => game.id
    
    assert_response :success
    assert_template :show
    assert assigns(:game)
  end
  
  test "show invalid" do
    get :show, :id => '0'
    
    assert_redirected_to root_url
    assert flash[:alert]
  end    
  
  test "edit" do
    game = create(:game)
    get :edit, :id => game.id
    
    assert_response :success
    assert_template :edit
    assert assigns(:game)
  end
  
  test "update" do
    game = create :game
    put :update, :id => game.id, :game => { :notes => 'Notes' }
    
    game = create(:game)
    put :update, :id => game.id
    
    assert_redirected_to game_url(assigns(:game))
    assert flash[:notice]
  end
  
  test "update reorder" do
    game = create :game
    player_ids = game.players.collect { |p| p.id }.shuffle
    
    put :update, :id => game.id, :game => { :player_ids => player_ids }
    
    assert assigns(:game)
    game = assigns(:game).reload
    
    4.times.each { |n| assert_equal player_ids[n], game.players[n].id }
    assert_redirected_to game_url(assigns(:game))
  end
  
  test "update invalid" do
    game = create(:game)
    put :update, :id => game.id, :game => { :winner_id => nil }
    
    assert_template :edit
    assert assigns(:game)
  end
end
