require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with name, email, password, and password_confirmation"
  it "is invalid without name"
  it "is invalid without email"
end
