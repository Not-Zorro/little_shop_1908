class MerchantsController <ApplicationController

  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def new
  end

  def create
    Merchant.create(merchant_params)
    redirect_to "/merchants"
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    redirect_to "/merchants/#{merchant.id}"
  end

  def destroy
    merchant = Merchant.find(params[:id])
    merchant.items.each do |item|
      item.delete_reviews
    end
    merchant.items.destroy_all
    merchant.destroy
    redirect_to '/merchants'
  end
  
  private
    def merchant_params
      params.permit(:name,:address,:city,:state,:zip)
    end
end
