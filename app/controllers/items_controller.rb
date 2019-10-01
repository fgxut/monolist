class ItemsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :destroy]

  def new
    @item = Item.new
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      flash[:success] = "持ち物が投稿されました"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
  end

  private

    def item_params
      params.require(:item).permit(:content)
    end
end