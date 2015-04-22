class PhotosController < ApplicationController
  def create
    @contest = Contest.find params[:contest_id]

    @photo = Photo.new(photo_params)
    @photo.contest = @contest
    if @photo.save
      redirect_to contest_path(@contest), notice: 'Photo successfully submitted'
    else
      render template: 'contests/show'
    end
  end

  private

  def photo_params
    params.require(:photo).permit :caption, :name, :email, :image_large_url, :image_medium_url, :image_thumb_url
  end
end