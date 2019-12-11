# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    unless @item.iine?(current_user)
      @item.iine(current_user)
      @item.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end

  def destroy
    @item = Like.find(params[:id]).item
    if @item.iine?(current_user)
      @item.uniine(current_user)
      @item.reload
      respond_to do |format|
        format.html { redirect_to request.referrer || root_url }
        format.js
      end
    end
  end
end
