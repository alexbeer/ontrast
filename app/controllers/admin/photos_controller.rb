class Admin::PhotosController < ApplicationController
  before_filter :authenticate_admin!
  
  def destroy
    contest = Contest.find params[:contest_id]
    photo = contest.photos.find params[:id]
    photo.destroy
    redirect_to admin_contest_path(contest)
  end
end