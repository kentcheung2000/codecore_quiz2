require 'rails_helper'

RSpec.describe User, type: :model do


  it "returns the name " do
    u = User.new({name: "Kent Cheung"})
    expect(u.name).to eq("Kent Cheung")
  end

  it "generate a password_digest upon saving" do
    u = User.new email: "john@smith.com", password: "supersecret"
    u.save
    expect(u.password_digest).to be

  end



end
