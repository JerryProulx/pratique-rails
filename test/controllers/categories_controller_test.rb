require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
    
    def setup
        @category = Category.create(name: "sport")
        @user1 = User.create(username: "JohnDoe", email: "john@example.com", password: "password", admin: true)
        @user2 = User.create(username: "JaneDoe", email: "jane@example.com", password: "password", admin: false)
    end
    
    test "should get categories index" do
        get :index
        assert_response :success
    end
    
    test "should get new" do
        session[:user_id] = @user1.id
        get :new
        assert_response :success
    end
    
    test "should get show" do
        get(:show, { id: @category.id})
        assert_response :success
    end
    
    test "should redirect when admin not logged in" do
        session[:user_id] = @user2.id
        assert_no_difference 'Category.count' do
            post :create, category: {name: "sports"}
        end
        assert_redirected_to categories_path
    end
end