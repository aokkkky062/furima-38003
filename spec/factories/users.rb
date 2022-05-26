FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { '1a' + Faker::Internet.unique.password(min_length: 6) }
    password_confirmation { password }
    last_name { '春日' }
    first_name { '俊彰' }
    last_name_kana { 'カスガ' }
    first_name_kana { 'トシアキ' }
    birthday { Faker::Date.birthday }
  end
end
