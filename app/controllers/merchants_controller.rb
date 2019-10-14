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
    merchant = Merchant.create(merchant_params)
    if merchant.save
      redirect_to "/merchants"
    else
      flash.now[:notice] = "Please fill in all fields"
      render :new
    end
  end

  def edit
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.update(merchant_params)
    if merchant.save
      redirect_to "/merchants/#{merchant.id}"
    else
      flash[:notice] = "Please fill in all fields"
      redirect_to "/merchants/#{params[:id]}/edit"
    end
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
