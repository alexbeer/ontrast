class Admin::AdminsController < ApplicationController
  before_filter :authenticate_admin!

  def index
    @admins = Admin.order(email: :asc)
  end

  def new
    @admin = Admin.new
  end

  def create
    @admin = Admin.new admin_params

    if @admin.save
      redirect_to admin_admins_path, notice: 'Admin user was succesfully created'
    else
      render action: 'new'
    end
  end

  def edit
    @admin = Admin.find params[:id]
  end

  def update
    @admin = Admin.find params[:id]
    current_admin_id = current_admin.id

    if @admin.update_with_password_optional admin_params
      sign_in @admin, bypass: true
      redirect_to admin_admins_path, notice: 'Admin user was succesfully updated'
    else
      render action: 'edit'
    end
  end

  def destroy
    @admin = Admin.find params[:id]
    @admin.destroy!
    redirect_to admin_admins_path
  end

  private

  def admin_params
    params.require(:admin).permit :email, :password, :password_confirmation
  end
end