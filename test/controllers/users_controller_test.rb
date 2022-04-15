require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
    @non_activated_user = users(:non_activated)
  end
  
  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should not allow the admin attribute to be edited via the web" do
    log_in_as(@other_user)                                                    # @other_userでログインする
    assert_not @other_user.admin?                                             # @toher_userが管理権限あれば(adminがtrueなら)falseを返す
    patch user_path(@other_user), params: {                                   # /users/@other_user へparamsハッシュの中身を送る
                                  user: { password:               'password',
                                          password_confirmation:  'password',
                                          admin: true } }
    assert_not @other_user.reload.admin?                                      # @other_userを再読み込みし、admin論理値が変更されてないか検証(falseやnilならtrue)
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_redirected_to root_url
  end

  test "should not allow the not activated attribute" do
    log_in_as (@non_activated_user)                                               # 非有効化ユーザーでログイン
    assert_not @non_activated_user.activated?                                   # 有効化でないことを検証
    get users_path                                                              # /usersを取得
    assert_select "a[href=?]", user_path(@non_activated_user), count: 0         # 非有効化ユーザーが表示されていないことを確認
    get user_path(@non_activated_user)                                          # 非有効化ユーザーidのページを取得
    assert_redirected_to root_url                                               # ルートurlにリダイレクトされればtrue
  end
end
