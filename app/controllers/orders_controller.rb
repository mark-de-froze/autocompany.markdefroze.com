class OrdersController < AuthenticateController
  load_and_authorize_resource

  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  def index
    @orders = Order.order(:status).page params[:orders_page]
    @search = params[:search].to_s

    @orders = @orders.where('lower(title) LIKE ?', '%'+@search.downcase+'%') if @search.size > 3

  end

  # GET /orders/1
  def show
    @order_id = params[:id]
    @tasks = @order.tasks
    @materials = @order.materials
  end

  # GET /orders/new
  def new
    @order = Order.new
    @order.mileage = 0
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  def create
    @order = Order.new(order_params)

    if @order.save
      redirect_to @order, notice: 'Order was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /orders/1
  def update
    if @order.update(order_params)
      redirect_to @order, notice: 'Order was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /orders/1
  def destroy
    @order.destroy
    redirect_to orders_url, notice: 'Order was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.require(:order).permit(:title, :content, :car_id, :client_id, :worker_id, :finished_at, :created_at, :mileage, :status)
    end
end
