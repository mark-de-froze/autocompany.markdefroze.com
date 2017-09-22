class ClientsController < AuthenticateController
  load_and_authorize_resource

  before_action :set_client, only: [:show, :edit, :update, :destroy]
  before_action :set_users, only: [:new, :edit, :create, :update]
  before_action :redirect_client, only: [:index]

  # GET /clients
  def index
    @clients = Client.page params[:page]
  end

  # GET /clients/1
  def show
    @cars = @client.cars.page params[:cars_page]
    @orders = @client.orders.page params[:orders_page]
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
    @users = @users.except_id(@client.user.id)
  end

  # POST /clients
  def create
    @client = Client.new(client_params)

    if @client.save
      redirect_to @client, notice: 'Client was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /clients/1
  def update
    if @client.update(client_params)
      redirect_to @client, notice: 'Client was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /clients/1
  def destroy
    @client.destroy
    redirect_to clients_url, notice: 'Client was successfully destroyed.'
  end

  private
    def redirect_client
      redirect_to client_url(Client.with_role(:client, current_user).pluck(:id)) if current_user.has_role? :clients
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find(params[:id])
    end

    def set_users
      @users = User.all
    end
    # Only allow a trusted parameter "white list" through.
    def client_params
      params[:client][:phone] = params[:client][:phone].delete('+')
      params.require(:client).permit(:title, :content, :user_id, :phone, { user_ids:[] })
    end
end
