class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  # GET /users/1
  # GET /users/1.json
  def show
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by_username(params[:id])
    raise ActiveRecord::RecordNotFound unless @user
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :first_name, :middle_name, :last_name, :phone, :picurl)
    end
end
