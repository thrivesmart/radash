class Account::UsersController < ApplicationController
  before_filter :enforce_auth
  before_action :set_user

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to [:account, @user], notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: [:account, @user] }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by_username(params[:id])
    raise ActiveRecord::RecordNotFound unless @user && (@user.id.to_s == authed_user.id.to_s || authed_user.superuser)
  end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :first_name, :middle_name, :last_name, :phone, :picurl)
    end
end
