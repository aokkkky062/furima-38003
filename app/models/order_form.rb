class OrderForm
  include ActiveModel::Model
  attr_accessor :user_id, :item_id, :postal_code, :area_id, :municipality, :address, :building_name, :phone_number

  with_options presence: true do
    validates :user_id
    validates :item_id
    validates :postal_code
    validates :area_id
    validates :municipality
    validates :address
    validates :phone_number
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(postal_code: postal_code, area_id: area_id, municipality: municipality, address: address,
                           building_name: building_name, phone_number: phone_number)
  end
end
