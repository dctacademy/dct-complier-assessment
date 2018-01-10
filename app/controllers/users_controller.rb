class UsersController < ApplicationController

  load_and_authorize_resource

  def index
		@users = User.all
	end

  def new
		@user = User.new
	end


  def create
		@user = User.new(user_params)
		User.invite!(user_params)
    if @user.save
      redirect_to root_path ,notice: "successfully sent invitation."
    else
      redirect_to root_path, notice: "Sent invitation."
    end
	end

  def show
		@user = User.find(params[:id])
	end

  def edit
  @user = User.find(params[:id])
  end

  def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			redirect_to users_path, notice:" Successfully updated user"
		else
			render action: "edit"
		end
	end

  def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to users_path, notice: "Successfully deleted user"
	end

  private

	def user_params
		params[:user].permit(:email, :username, :student_id, :password, role_ids: [])
	end

end
