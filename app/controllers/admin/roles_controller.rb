class Admin::RolesController < AuthenticateController
  load_and_authorize_resource param_method: :admin_role_params

  before_action :set_admin_role, only: [:show, :edit, :update, :destroy]

  # GET /admin/roles
  def index
    @admin_roles = Admin::Role.all
  end

  # GET /admin/roles/1
  def show
  end

  # GET /admin/roles/new
  def new
    @admin_role = Admin::Role.new
  end

  # GET /admin/roles/1/edit
  def edit
  end

  # POST /admin/roles
  def create
    @admin_role = Admin::Role.new(admin_role_params)

    if @admin_role.save
      redirect_to @admin_role, notice: 'Role was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/roles/1
  def update
    if @admin_role.update(admin_role_params)
      redirect_to @admin_role, notice: 'Role was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /admin/roles/1
  def destroy
    @admin_role.destroy
    redirect_to admin_roles_url, notice: 'Role was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_role
      @admin_role = Admin::Role.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def admin_role_params
      params[:admin_role][:resource_type] = nil unless params[:admin_role][:resource_type].present?

      params.require(:admin_role).permit(:name, :resource_id, :resource_type)
    end
end
