User.create!(user_name: "Example User",
             account_name: "Example User",
             email: "example@test.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  user_name  = Faker::Name.name
  account_name = "#{n+1}name"
  email = "example-#{n+1}@test.com"
  password = "password"
  User.create!(user_name: user_name,
               account_name: account_name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end