require 'rails_helper'

RSpec.describe OrderForm, type: :model do
  before do
    @user = FactoryBot.build(:user)
    @item = FactoryBot.build(:item)
    @order_form = FactoryBot.build(:order_form, user_id: @user.id, item_id: @item.id)
    @order_form.user_id = 1
    @order_form.item_id = 1
  end

  describe '配送先の情報の登録' do
    context '配送先の情報が登録できる時' do
      it '全ての入力事項が、存在すれば登録できる' do
        expect(@order_form).to be_valid
      end
      it 'user_idが空でなければ保存できる' do
        @order_form.user_id = 1
        expect(@order_form).to be_valid
      end
      it 'item_idが空でなければ保存できる' do
        @order_form.item_id = 1
        expect(@order_form).to be_valid
      end
      it '郵便番号が「3桁＋ハイフン＋4桁」の組み合わせであれば保存できる' do
        @order_form.postal_code = '123-4560'
        expect(@order_form).to be_valid
      end
      it '都道府県が「---」でなければ保存できる' do
        @order_form.area_id = 2
        expect(@order_form).to be_valid
      end
      it '市区町村が空でなければ保存できる' do
        @order_form.municipality = '豊島区'
        expect(@order_form).to be_valid
      end
      it '番地が空でなければ保存できる' do
        @order_form.address = '池袋1-234'
        expect(@order_form).to be_valid
      end
      it '建物名が空でも保存できる' do
        @order_form.building_name = nil
        expect(@order_form).to be_valid
      end
      it '電話番号が11番桁以内かつハイフンなしであれば保存できる' do
        @order_form.phone_number = 12_345_678_910
        expect(@order_form).to be_valid
      end
      it "tokenがあれば保存ができること" do
        expect(@order_form).to be_valid
      end
    end

    context '配送先の情報が登録できないとき' do
      it 'user_idが空だと登録できない' do
        @order_form.user_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空だと登録できない' do
        @order_form.item_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Item can't be blank")
      end
      it '郵便番号が空だと保存できないこと' do
        @order_form.postal_code = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号が半角の「3桁ハイフン4桁」でないと登録できない' do
        @order_form.postal_code = '1111111'
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it '都道府県が空だと保存できないこと' do
        @order_form.area_id = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Area can't be blank")
      end
      it '都道府県が「---」だと保存できないこと' do
        @order_form.area_id = 1
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Area can't be blank")
      end
      it '市区町村が空だと保存できないこと' do
        @order_form.municipality = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Municipality can't be blank")
      end
      it '番地が空だと保存できないこと' do
        @order_form.address = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号が空だと保存できないこと' do
        @order_form.phone_number = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号にハイフンがあると保存できないこと' do
        @order_form.phone_number = "070 - 1234 - 5678"
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が9桁以内だと保存できないこと' do
        @order_form.phone_number = "074134564"
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が12桁以上だと保存できないこと' do
        @order_form.phone_number = "070123456789"
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include('Phone number is invalid')
      end
      it 'トークンが空だと保存できないこと' do
        @order_form.token = nil
        @order_form.valid?
        expect(@order_form.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
