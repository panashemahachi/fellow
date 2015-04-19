require 'test_helper'

class FellowshipAdditionTest < ActionMailer::TestCase
  test "added_to_fellowship" do
    mail = FellowshipAddition.added_to_fellowship
    assert_equal "Added to fellowship", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
