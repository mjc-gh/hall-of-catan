require 'test_helper'

class LocationsControllerTest < ActionController::TestCase
  setup do
    grant_access!
  end
  
  teardown do
    mocha_teardown
  end
  
  test "new" do
    get :new
    
    assert_response :success
    assert assigns(:location)
  end
  
  test "create" do
    assert_difference('Location.count') do
      post :create, :location => attributes_for(:location)
    end
    
    assert_redirected_to location_url(assigns(:location))
    assert flash[:notice]
  end
  
  test "create invalid" do
    post :create
    
    assert_template :new
    assert assigns(:location)
  end
  
  test "index" do
    get :index
    
    assert_response :success
    assert_template :index
    assert assigns(:locations)
  end
  
  test "show" do
    location = create(:location)
    get :show, :id => location.id
    
    assert_response :success
    assert_template :show
    assert assigns(:location)
  end
  
  test "show invalid" do
    get :show, :id => '0'
    
    assert_redirected_to root_url
    assert flash[:alert]
  end  
  
  test "edit" do
    location = create(:location)
    get :edit, :id => location.id
    
    assert_response :success
    assert_template :edit
    assert assigns(:location)
  end
  
  test "update" do
    location = create :location
    put :update, :id => location.id, :location => attributes_for(:location)
    
    assert_redirected_to location_url(assigns(:location))
    assert flash[:notice]
  end
  
  test "update invalid" do
    location = create(:location)
    put :update, :id => location.id, :location => { :name => 0 }
    
    assert_template :edit
    assert assigns(:location)
  end
end
