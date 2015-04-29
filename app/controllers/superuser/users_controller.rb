class Superuser::UsersController < ApplicationController
  before_filter :enforce_auth
  before_filter :enforce_superuser
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to [:superuser, @user], notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: [:superuser, @user] }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to superuser_users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:username, :email, :first_name, :middle_name, :last_name, :phone, :picurl, :redditid, :superuser)
  end
end
