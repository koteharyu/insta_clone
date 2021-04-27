puts "ダミーユーザー作成開始！"
10.times do
  user = User.create(
    name: Faker::Games::Pokemon.unique.name,
    email: Faker::Internet.unique.email,
    password: "password",
    password_confirmation: "password",
  )
  puts "#{user.name}の作成完了!"
end
