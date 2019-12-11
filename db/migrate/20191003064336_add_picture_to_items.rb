# frozen_string_literal: true

class AddPictureToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :picture, :string
  end
end
