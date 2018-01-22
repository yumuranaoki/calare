require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @event = @user.events.build(title: 'aaaaa', start: Time.now, end: Time.now.since(5.hour) )
  end
  
  test 'should be valid' do
    assert @event.valid?
  end
  
  test 'title should be present' do
    @event.title = ''
    assert_not @event.valid?
  end
  
  test 'start should be present' do
    @event.start = nil
    assert_not @event.valid?
  end
  
  test 'end should be present' do
    @event.end = nil
    assert_not @event.valid?
  end
  
  test 'user_id should be present' do
    @event.user_id = ''
    assert_not @event.valid?
  end
  
end
