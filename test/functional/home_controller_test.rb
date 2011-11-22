require 'test_helper'

class HomeControllerTest < ActionController::TestCase
  setup do
    grant_access!
  end
  
  teardown do
    mocha_teardown
  end  
  
  test "index" do
    get :index
    
    assert_response :success
    assert_template :index
    assert assigns(:games)
  end
end
