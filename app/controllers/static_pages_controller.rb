# frozen_string_literal: true

class StaticPagesController < ApplicationController
  def top; end

  def home
    if logged_in?
      @item = current_user.items.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help; end

  def about; end

  def contact; end
end
