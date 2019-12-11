# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.integer :user_id, null: false
      t.integer :item_id, null: false

      t.timestamps

      t.index :user_id
      t.index :item_id
      t.index %i[user_id item_id], unique: true
    end
  end
end
