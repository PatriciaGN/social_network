require "user"

describe User do
    it "generates the variables username and email_address" do
        user = User.new
        user.username = "username"
        user.email_address = "email"
    end
end
