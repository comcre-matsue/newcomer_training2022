require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  # def setup
  #   @user = User.new(name: "Example User", email: "user@example..com", 
  #                    password: "foo", password_confirmation: "bar")
  # end

  test "invalid signup information" do 
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { user: { name:  "", 
                                 email: "user@invalid", 
                                 password: "foo", 
                                 password_confirmation: "bar" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation', 1
    assert_select 'div.field_with_errors', 8
    assert_select 'form[action="/signup"]'
  end

end
