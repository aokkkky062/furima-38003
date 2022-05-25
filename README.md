## users テーブル

| Column             | Type   | Options                   |
|--------------------|--------|---------------------------|
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birthday           | date   | null: false               |

### Association
- has_many :items 
- has_many :purchase_records


## items テーブル

| Column       | Type    | Options     |
|--------------|---------|-------------|
| name         | string  | null: false |
| explanation  | text    | null: false | <!-- 商品の説明 -->
| category_id  | integer | null: false |
| condition_id | integer | null: false | <!-- 状態 -->
| charge_id    | integer | null: false | <!-- 配送料負担 -->
| area_id      | integer | null: false |
| days_of_ship | integer | null: false | <!-- 発送日の目安 -->
| price        | integer | null: false |

### Association
- belongs_to :user
- has_one :purchase_record


## purchase_records テーブル

| Column       | Type       | Options                        |
|--------------|------------|--------------------------------|
| user_id      | references | null: false, foreign_key: true |
| item_id      | references | null: false, foreign_key: true |


- belongs_to :user
- belongs_to :item
- has_one :shipping_address


## shipping_addresses テーブル

| Column        | Type    | Options     |
|---------------|---------|-------------|
| postal_code   | string  | null: false |
| prefecture    | string  | null: false | <!-- 都道府県 -->
| municipality  | string  | null: false | <!-- 市区町村 -->
| address       | integer | null: false | <!-- 番地 -->
| building_name | string  | 
| phone_number  | integer | null: false |

- belongs_to :purchase_record