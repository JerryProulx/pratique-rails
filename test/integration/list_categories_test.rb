require 'test_helper'

class ListCategoriesTest < ActionDispatch::IntegrationTest
    
    def setup
        @category = Category.create(name: "books")
        @category2 = Category.create(name: "programming")
        @category3 = Category.create(name: "books1")
        @category4 = Category.create(name: "programming1")
        @category5 = Category.create(name: "books2")
        @category6 = Category.create(name: "programming2")
    end
    
    test "should show categories listing" do
        get categories_path
        assert_template 'categories/index'
        assert_select "a[href=?]", category_path(@category), test: @category.name
        assert_select "a[href=?]", category_path(@category2), test: @category2.name
        assert_select "a[href=?]", category_path(@category3), test: @category3.name
        assert_select "a[href=?]", category_path(@category4), test: @category4.name
        assert_select "a[href=?]", category_path(@category5), test: @category5.name
        assert_select "a[href='?']", false, 'This page must contains a maximum of 5 items'
    end
end