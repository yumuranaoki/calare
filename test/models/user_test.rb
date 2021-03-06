require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(
      name: 'user1', email: 'user1@example.com',
      password: 'user1', password_confirmation: 'user1'
      )
    @group = groups(:one)
  end
  
  test 'should be valid' do
    assert @user.valid?
  end
  
  test 'name should be present' do 
    @user.name = ' '
    assert_not @user.valid?
  end
  
  test 'email should be present' do 
    @user.email = ' '
    assert_not @user.valid?
  end
  
  test 'name length should be moderate' do 
    @user.name = 'a'*21
    assert_not @user.valid?
  end
  
  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
  
  test 'email validation should reject invalid adresses' do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should not be valid"
    end
  end
  
  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test 'password length shoud not be too long' do
    @user.password = @user.password_confirmation = 'a'*21
    assert_not @user.valid?
  end
  
  test 'password length shoud not be too short' do
    @user.password = @user.password_confirmation = 'a'*3
    assert_not @user.valid?
  end
  
  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
  
  test 'follow and unfollow groups' do
    assert_not @user.following?(@group)
    #@user.follow(@group)
    #assert @user.following?(@group)
    #assert @group.followers.include?(@user)
    #assert @user.followeds.include?(@group)
    
  end
  
end
