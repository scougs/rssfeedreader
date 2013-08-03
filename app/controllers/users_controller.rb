class UsersController < ApplicationController

  def index
    @users = User.all
  end


  def show
    @user = User.find(params[:id])
  end


  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  # def create
  #     @user = User.new(params[:user])
  #     if @user.save
  #             session[:user_id] = @user.id
  #       redirect_to users_path, notice: "Account created. You are now logged in."
  #     else
  #       render 'new'
  #     end
  #   end


  def update
    @user = User.all
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to user_path, notice: 'User successfully updated'
    else
      render action: 'edit'
    end
  end


  def destroy
    @user = User.find(params[:id])

    if @user.destroy
      redirect_to users_path, alert: 'User successfully deleted' 
    else
      redirect_to user
    end

  end

  
  def my_profile
    @user = current_user
    render :show
  end

end