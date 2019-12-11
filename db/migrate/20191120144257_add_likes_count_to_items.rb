# frozen_string_literal: true

class AddLikesCountToItems < ActiveRecord::Migration[5.1]
  class MigrationUser < ApplicationRecord
    self.table_name = :items
  end

  def up
    _up
  rescue StandardError => e
    _down
    raise e
  end

  def down
    _down
  end

  private

  def _up
    MigrationUser.reset_column_information

    unless column_exists? :items, :likes_count
      add_column :items, :likes_count, :integer, null: false, default: 0
    end
  end

  def _down
    MigrationUser.reset_column_information

    remove_column :items, :likes_count if column_exists? :items, :likes_count
  end
end
