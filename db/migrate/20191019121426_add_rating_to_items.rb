class AddRatingToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :rating, :float
  end
end
