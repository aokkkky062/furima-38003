class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :charge
  belongs_to :area
  belongs_to :days_of_ship

  #空の投稿を保存できないようにする
  with_options presence: true do
    validates :category_id
    validates :condition_id
    validates :charge_id
    validates :area_id
    validates :days_of_ship_id
  end


  #ジャンルの選択が「---」の時は保存できないようにする
  with_options numericality: { other_than: 1, message: "Can't be blank" } do
    validates :category_id
    validates :condition_id
    validates :charge_id
    validates :area_id
    validates :days_of_ship_id
  end
end
