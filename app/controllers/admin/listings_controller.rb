class Admin::ListingsController < Admin::BaseController

  def index
    @listings = Listing.all
  end

  def new
    @listing = Listing.new
    @title = "Create"
  end

  def create
    @listing = Listing.new(listing_params)
    if @listing.save
      flash[:notice] = "Listing created!"
      redirect_to listings_path
    else
      flash[:error] = "Invalid input - Please try creating listing again"
      render '/admin/listings/new.html.erb'
    end
  end

  def show
    @listing = Listing.find(params[:id])
  end

  def edit
    @title = "Update"
    @listing = Listing.find(params[:id])
  end

  def update
    @listing = Listing.find(params[:id])
    if @listing.update(name: params[:listing][:name],
                    description: params[:listing][:description],
                    listing_cost: params[:listing][:listing_cost],
                    image: params[:listing][:image],
                    lat: params[:listing][:lat],
                    long: params[:listing][:long])
      flash[:notice] = "Listing updated!"
      redirect_to admin_listings_path
    else
      flash[:error] = "Invalid input - Please try updating listing again"
      render '/admin/listings/edit.html.erb'
    end
  end

  def destroy
    @listing = Listing.find(params[:id])
    @listing.destroy
    redirect_to admin_listings_path
  end
  private

  def listing_params
    params.require(:listing).permit(:name, :description, :listing_cost, :destination_id, :image_url, :image, :lat, :long)
  end
end
