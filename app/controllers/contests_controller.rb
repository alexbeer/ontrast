class ContestsController < ApplicationController
  include S3PresignedPost

  def new
    @contest = Contest.new

    @s3_presigned_posts = (1..100).map { |i| s3_presigned_post('contests') }
  end

  def create
    @contest = Contest.new contest_params

    if @contest.save
      redirect_to contest_path(@contest)
    else
      @photos = @contest.photos_for_view(params[:page])
      @s3_presigned_posts = (1..100).map { |i| s3_presigned_post('contests') }
      render action: 'new'
    end
  end

  def index
    @contests = Contest.current_contests(10)
  end

  def previous
    @contests = Contest.previous_contests(10)
    render action: 'index'
  end

  def show
    @contest = Contest.find params[:id]
    @photos = @contest.photos_for_view(params[:page])
    @photo = Photo.new contest: @contest
    @s3_presigned_posts = (1..100).map { |i| s3_presigned_post('photos') }
  end

  private

  def contest_params
    params.require(:contest).permit :title, :status, :email, :prize, :description, :start_at, :end_at, :rules, :name, :company,
                                    :image_large_url, :image_medium_url, :image_thumb_url,
                                    :facebook_handle, :twitter_handle, :instagram_handle, :website_url
  end
end