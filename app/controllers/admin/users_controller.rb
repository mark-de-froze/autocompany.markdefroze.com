class Admin::UsersController < AuthenticateController
  load_and_authorize_resource param_method: :admin_user_params

  before_action :set_admin_user, only: [:show, :edit, :update, :destroy]
  before_action :except_password, only: [:update, :create]

  # GET /admin/users
  def index
    @admin_users = Admin::User.page params[:page]
  end

  # GET /admin/users/1
  def show
  end

  # GET /admin/users/new
  def new
    @admin_user = Admin::User.new
  end

  # GET /admin/users/1/edit
  def edit
  end

  # POST /admin/users
  def create
    @admin_user = Admin::User.new(admin_user_params)

    if @admin_user.save
      redirect_to @admin_user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/users/1
  def update
    if @admin_user.update(admin_user_params)
      redirect_to @admin_user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/users/1
  def destroy
    @admin_user.destroy
    redirect_to admin_users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user
      @admin_user = Admin::User.find(params[:id])
    end

    def except_password

    end

    # Only allow a trusted parameter "white list" through.
    def admin_user_params
      if params.require(:admin_user)[:password].blank? and params.require(:admin_user)[:password_confirmation].blank?
        params.require(:admin_user).permit(:email, { role_ids:[] })
      else
        params.require(:admin_user).permit(:password, :password_confirmation, :email, { role_ids:[] })
      end
    end

end
