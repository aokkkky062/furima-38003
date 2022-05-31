class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items

  with_options presence: true do
    validates :nickname

    VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
    validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'は半角英数を両方含む必要があります' }   # パスワードは半角英数字混合の入力が必須

    with_options format: { with: /\A[ぁ-んァ-ン一-龥]/, message: '全角(漢字・ひらがな・カタカナ)のみが使えます' } do
      validates :last_name
      validates :first_name
    end

    with_options format: { with: /\A[ァ-ヶー－]+\z/, message: '全角(カタカナ)のみが使えます' } do
      validates :last_name_kana
      validates :first_name_kana
    end

    validates :birthday
  end
end
