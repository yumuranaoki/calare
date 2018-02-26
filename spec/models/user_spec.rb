require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with name, email, password, and password_confirmation" do
    user = User.new(
      name: "tanaka takeshi",
      email: "tanaka_takeshi@example.com",
      password: "tanakatakeshi",
      password_confirmation: "tanakatakeshi"
    )
    expect(user).to be_valid
  end
  it "is invalid without name" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "is invalid without email" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid without password" do
    user = User.new(password: nil)
    #error messageで書き換え
    expect(user).not_to be_valid
  end

  it "is invalid with a duplicate email address" do
    User.create(
      name: "gouda takeshi",
      email: "tanaka_takeshi@example.com",
      password: "goudatakeshi",
      password_confirmation: "goudatakeshi"
    )
    user = User.new(
      name: "tanaka takeshi",
      email: "tanaka_takeshi@example.com",
      password: "tanakatakeshi",
      password_confirmation: "tanakatakeshi"
    )
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end
end
