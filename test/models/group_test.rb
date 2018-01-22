require 'test_helper'

class GroupTest < ActiveSupport::TestCase
  def setup
    @group =  groups(:one)
    @user = users(:michael)
  end
  
  test 'should be valid' do 
    assert @group.valid?
  end
  
  test 'title should be present' do
    @group.title = nil
    assert_not @group.valid?
  end
  
  test 'starttime should be present' do
    @group.starttime = nil
    assert_not @group.valid?
  end
  
  test 'endtime should be present' do
    @group.endtime = nil
    assert_not @group.valid?
  end
  
  test 'timelength should be present' do
    @group.timelength = nil
    assert_not @group.valid?
  end
  
  test 'follow and unfollow users' do
    assert_not @group.following? (@user)
    @group.follow(@user)
    assert @group.following?(@user)
    assert @user.followers.include?(@group)
    @group.unfollow(@user)
    assert_not @group.following?(@user)
  end
end
