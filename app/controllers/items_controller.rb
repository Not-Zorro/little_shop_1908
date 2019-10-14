class ItemsController<ApplicationController

  def index
    if params[:merchant_id]
      @merchant = Merchant.find(params[:merchant_id])
      @items = @merchant.items
    else
      @items = Item.all
    end
  end

  def show
    @item = Item.find(params[:id])
    @review_average = @item.review_average.round(1)
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.create(item_params)
    if item.save
      redirect_to "/merchants/#{merchant.id}/items"
    else
      flash[:notice] = item.errors.full_messages.to_sentence
      redirect_to "/merchants/#{merchant.id}/items/new"
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    item = Item.find(params[:id])
    item.update(item_params)
    if item.save
      redirect_to "/items/#{item.id}"
    else
      flash[:notice] = item.errors.full_messages.to_sentence
      redirect_to "/items/#{item.id}/edit"
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.delete_reviews
    item.destroy
    redirect_to "/items"
  end

  private

  def item_params
    params.permit(:name,:description,:price,:inventory,:image)
  end

end
