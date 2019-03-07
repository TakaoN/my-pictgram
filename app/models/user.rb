class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, format: { with: /[A-Za-z0-9._+]+@[A-Za-z]+.[A-Za-z]/ }
  
  #パスワードの文字数制限を追加する
  #validates :password, length: { in: 8..32 }

  #パスワードをアルファベット、数字の混合のみ可能にしてください
  PW_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,32}\z/i
  validates :password, presence: true, format: { with: PW_REGEX }

  # 名前の長さに制限を追加する
  validates :name, length: { maximum: 15 }

  has_secure_password

  has_many :topics
  has_many :favorites
  has_many :favorite_topics, through: :favorites, source: 'topic'
  has_many :comments
  has_many :comments_topics, through: :comments, source: 'topic'
end
