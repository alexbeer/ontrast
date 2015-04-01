class ContestsController < ApplicationController
  def new
    @contest = Contest.new
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
    params.require(:contest).permit :title, :header_image, :status, :email, :prize, :description, :start_at, :end_at, :rules, :name, :company
  end
end