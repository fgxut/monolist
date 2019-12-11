# frozen_string_literal: true

# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  item_id    :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_likes_on_item_id              (item_id)
#  index_likes_on_user_id              (user_id)
#  index_likes_on_user_id_and_item_id  (user_id,item_id) UNIQUE
#


require 'rails_helper'

RSpec.describe Like, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
