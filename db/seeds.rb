user_params = [
  {
    email: 'example@example.com',
    password: 'password'
  }
]

User.delete_all
User.create!(user_params)
puts 'ユーザーの初期データの投入に成功しました!'

post_params = [
  {
    user_id: 1,
    title: 'React',
    content: 'ユーザインターフェース構築のための JavaScript ライブラリ'
  },
  {
    user_id: 1,
    title: 'Vue.js',
    content: 'The Progressive JavaScript Framework'
  },
  {
    user_id: 1,
    title: 'Angular',
    content: 'モバイルとデスクトップ，ひとつのフレームワーク'
  }
]

Post.delete_all
Post.create!(post_params)
puts 'Postの初期データの投入に成功しました!'

puts 'すべての初期データ投入に成功しました!'
