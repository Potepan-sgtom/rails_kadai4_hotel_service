class User < ApplicationRecord
  has_many :rooms
  has_many :reservations
  before_save :downcase_email
  has_secure_password
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true,
                    length: { maximum: 100 },
                    format: { with: VALID_EMAIL_REGEX }
  validates :introduction, length: { maximum: 50 }
  #更新時のみパスワード省略可のため、allow_nilをセット
  validates :password, presence:true, length: { maximum: 10 }, allow_nil: true
  mount_uploader :image, ImageUploader
  
  private
  # メールアドレスをすべて小文字にする
    def downcase_email
      self.email.downcase!
    end
end
