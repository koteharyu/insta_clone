puts "ダミー投稿の作成開始！"

User.limit(10).each do |user|
  post = user.posts.create(body: Faker::Hacker.say_something_smart, remote_images_urls: %w[https://picsum.photos/350/350/?random https://picsum.photos/350/350/?random])
  puts "#{post.id}の作成完了！"
end
