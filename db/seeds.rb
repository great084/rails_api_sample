user_params = [
  {
    email: 'example@example.com',
    password: 'password'
  },
  {
    email: 'test@example.com',
    password: 'password'
  }
]

User.destroy_all
User.create!(user_params)
puts 'ユーザーの初期データの投入に成功しました!'

user = User.find_by(email: 'test@example.com')

# post_params = [
#   {
#     user_id: 1,
#     title: 'React',
#     content: 'ユーザインターフェース構築のための JavaScript ライブラリ'
#   },
#   {
#     user_id: 1,
#     title: 'Vue.js',
#     content: 'The Progressive JavaScript Framework'
#   },
#   {
#     user_id: 1,
#     title: 'Angular',
#     content: 'モバイルとデスクトップ，ひとつのフレームワーク'
#   }
# ]

# Post.delete_all
# Post.create!(post_params)
# puts 'Postの初期データの投入に成功しました!'

books_params = [
  {
    title: 'スラムダンク',
    author: '井上タケヒコ',
    description: '『SLAM DUNK』（スラムダンク）は、バスケットボール 主人公の不良少年桜木花道.本作品の舞台は神奈川県.第40回平成6年度（1994年）小学館漫画賞.ジャンプ歴代最高部数653万部を達成した'
  },
  {
    title: 'ヒストリエ',
    author: '岩明均',
    description: '紀元前4世紀の古代ギリシア世界を舞台に、マケドニア王国のアレクサンドロス大王（アレキサンダー大王）に仕えた書記官・エウメネスの波乱の生涯を描いている。エウメネスはプルタルコスの『英雄伝』（対比列伝）などにも登場する実在の人物である。'
  },
  {
    title: 'キングダム',
    author: '原泰久',
    description: '古代中国の春秋戦国時代末期における、戦国七雄の戦争を背景とした作品。中国史上初めて天下統一を果たした始皇帝と、それを支えた将軍李信が主人公。'
  }
]

user.books.delete_all
user.books.create!(books_params)
puts 'Booksの初期データの投入に成功しました!'

puts 'すべての初期データ投入に成功しました!'
