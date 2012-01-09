require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  setup do
    grant_access!
  end
  
  teardown do
    mocha_teardown
  end
  
  test "new" do
    get :new
    
    assert_response :success
    assert assigns(:player)
  end
  
  test "create" do
    assert_difference('Player.count') do
      post :create, :player => attributes_for(:player)
    end
    
    assert_redirected_to player_url(assigns(:player))
    assert flash[:notice]
  end
  
  test "create invalid" do
    post :create
    
    assert_template :new
    assert assigns(:player)
  end
  
  test "index" do
    get :index
    
    assert_response :success
    assert_template :index
    assert assigns(:players)
  end
  
  test "show" do
    player = create(:player)
    get :show, :id => player.id
    
    assert_response :success
    assert_template :show
    
    assert assigns(:player)
    assert assigns(:games)
  end
  
  test "show invalid" do
    get :show, :id => 0
    
    assert_redirected_to root_url
    assert flash[:alert]
  end
  
  test "edit" do
    player = create(:player)
    get :edit, :id => player.id
    
    assert_response :success
    assert_template :edit
    assert assigns(:player)
  end
  
  test "update" do
    player = create(:player)
    put :update, :id => player.id, :player => attributes_for(:player)
    
    assert_redirected_to player_url(assigns(:player))
    assert flash[:notice]
  end
  
  test "update invalid" do
    player = create(:player)
    put :update, :id => player.id, :player => { :first_name => 0 }
    
    assert_template :edit
    assert assigns(:player)
  end  
end
