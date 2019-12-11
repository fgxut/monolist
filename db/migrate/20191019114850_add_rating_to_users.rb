# frozen_string_literal: true

class AddRatingToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :rating, :float
  end
end
