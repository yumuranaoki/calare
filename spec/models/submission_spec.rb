require 'rails_helper'

RSpec.describe Submission, type: :model do
  it "is valid with title, access_id" do
    user = User.create(
      name: "tanaka takeshi",
      email: "tanaka_takeshi@example.com",
      password: "tanakatakeshi",
      password_confirmation: "tanakatakeshi"
    )

    submission = user.submissions.build(
      title: "hogehoge",
      access_id: "abcdefghijklmnopqrstuvwxyz"
    )
    expect(submission).to be_valid
  end

  it "does not allow duplicate access_id" do
    user = User.create(
      name: "tanaka takeshi",
      email: "tanaka_takeshi@example.com",
      password: "tanakatakeshi",
      password_confirmation: "tanakatakeshi"
    )

    user.submissions.create(
      title: "hogehoge",
      access_id: "abcdefghijklmnopqrstuvwxyz"
    )

    submission = user.submissions.build(
      title: "hogehoge",
      access_id: "abcdefghijklmnopqrstuvwxyz"
    )
    expect(submission).not_to be_valid
  end
end
