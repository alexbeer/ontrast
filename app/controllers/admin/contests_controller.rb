class Admin::ContestsController < ApplicationController
  include S3PresignedPost

  before_filter :authenticate_admin!

  def index
    @contests = Contest.pending.order(created_at: :asc)
  end

  def all
    @contests = Contest.order(created_at: :desc)
    render action: 'index'
  end

  def approve
    @contest = Contest.find params[:id]
    if @contest.approve
      redirect_to admin_contests_path, notice: 'Contest approved'
    else
      render action: 'edit'
    end
  end

  def edit
    @contest = Contest.find params[:id]
    @s3_presigned_posts = (1..100).map { |i| s3_presigned_post('contests') }
  end

  def update
    @contest = Contest.find params[:id]

    if @contest.update_attributes contest_params
      redirect_to admin_contests_path, notice: 'Contest updated'
    else
      render action: 'edit'
    end
  end

  def show
    @contest = Contest.find params[:id]
    @photos = @contest.photos_for_view(params[:page])
  end

  def destroy
    @contest = Contest.find params[:id]
    @contest.destroy
    redirect_to admin_contests_path, notice: 'Contest deleted'
  end

  private

  def contest_params
    params.require(:contest).permit :title, :status, :email, :prize, :description, :start_at, :end_at, :rules, :name, :company,
                                    :image_large_url, :image_medium_url, :image_thumb_url,
                                    :facebook_handle, :twitter_handle, :instagram_handle, :website_url
  end
end