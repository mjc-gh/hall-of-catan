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
    Player.any_instance.stubs(:valid?).returns(true)
    post :create
    
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
    player = Factory.create(:player)
    get :show, :id => player.id
    
    assert_response :success
    assert_template :show
    assert assigns(:player)
  end
  
  test "show invalid" do
    get :show, :id => '0'
    
    assert_redirected_to root_url
    assert flash[:alert]
  end
  
  test "edit" do
    player = Factory.create(:player)
    get :edit, :id => player.id
    
    assert_response :success
    assert_template :edit
    assert assigns(:player)
  end
  
  test "update" do
    Player.any_instance.stubs(:valid?).returns(true)
    
    player = Factory.create(:player)
    put :update, :id => player.id
    
    assert_redirected_to player_url(assigns(:player))
    assert flash[:notice]
  end
  
  test "update invalid" do
    player = Factory.create(:player)
    put :update, :id => player.id
    
    assert_template #:edit
    assert assigns(:player)
  end  
end
