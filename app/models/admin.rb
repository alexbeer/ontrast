class Admin < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def update_with_password_optional params
    if params[:password].blank?
      params = params.dup
      params.delete :password
      params.delete :password_confirmation
    end

    update_attributes params
  end
end
