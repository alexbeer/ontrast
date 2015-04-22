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
      render action: 'new'
    end
  end

  def index
    @contests = Contest.current_contests(10)
  end

  def show
    @contest = Contest.find params[:id]
    @photo = Photo.new contest: @contest
  end

  private

  def contest_params
    params.require(:contest).permit :title, :status, :email, :prize, :description, :start_at, :end_at, :rules, :name, :company, :image_large_url, :image_medium_url, :image_thumb_url
  end
end