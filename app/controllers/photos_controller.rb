class PhotosController < ApplicationController
  include S3PresignedPost

  def create
    @contest = Contest.find params[:contest_id]

    @photo = Photo.new(photo_params)
    @photo.contest = @contest
    if @contest.ended?
      redirect_to contest_path(@contest), flash: { error: 'Cannot submit a photo because the contest has ended' }
    elsif @photo.save
      redirect_to contest_path(@contest), notice: 'Photo successfully submitted'
    else
      @s3_presigned_posts = (1..100).map { |i| s3_presigned_post('contests') }
      @photos = @contest.photos_for_view(params[:page])
      render template: 'contests/show'
    end
  end

  def show
    @contest = Contest.find params[:contest_id]
    @photo = @contest.photos.find params[:id]
  end

  private

  def photo_params
    params.require(:photo).permit :caption, :name, :email, :image_large_url, :image_medium_url, :image_thumb_url,
                                  :facebook_handle, :twitter_handle, :instagram_handle, :website_url
  end
end