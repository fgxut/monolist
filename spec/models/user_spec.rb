require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with a user_name, account_name, email, and password" do
    user = User.new(
      user_name: "test",
      account_name: "test",
      email: "test@example.com",
      password: "hogehoge",
    )
    expect(user).to be_valid
  end
end
