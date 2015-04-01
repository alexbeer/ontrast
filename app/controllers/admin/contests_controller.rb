class Admin::ContestsController < ApplicationController
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
  end

  def destroy
    @contest = Contest.find params[:id]
    @contest.destroy
    redirect_to admin_contests_path, notice: 'Contest deleted'
  end

  private

  def contest_params
    params.require(:contest).permit :title, :header_image, :status, :email, :prize, :description, :start_at, :end_at, :rules, :name, :company
  end
end