class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update_user destroy]

  # GET /users
  def index
    @users = policy_scope(User)
  end

  # GET /users/:id
  def show
    authorize @user
  end

  # GET /users/new
  def new
    @user = User.new
    authorize @user
  end

  # GET /users/:id/edit
  def edit
    authorize @user
  end

  # POST /create_user
  def create_user
    @user = User.new(user_params)
    authorize @user, :create?

    if @user.save
      redirect_to @user
    else
      render :new
    end
  end

  # PATCH/PUT /users/:id
  def update_user
    authorize @user, :update?
    @user.skip_password_validation = true if user_params[:password].blank?
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  # DELETE /users/:id
  def destroy
    authorize @user
    @user.destroy
    redirect_to users_path
  end

  private

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :email, :birth_date, :first_name, :last_name,
                                 :password, :password_confirmation, :role)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
