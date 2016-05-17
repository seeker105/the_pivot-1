class PhotosController < ApplicationController

  def index
    @photos = Photo.all
    @categories = Category.all
    @slide_photos = Photo.limit(5)
  end

  def create
    @photo = Photo.new(photo_params)

    if @photo.save
      flash[:success] = "Photo: #{@photo.title} Created"
      redirect_to dashboard_path(current_user.id)
    else
      flash[:alert] = @photo.errors.full_messages.join(", ")
      redirect_to dashboard_path(current_user.id)
    end
  end

  def show
    @photo = Photo.find(params[:id])
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :description, :price, :image, :vendor_id)
  end

end
