class CarsController < AuthenticateController
  load_and_authorize_resource

  before_action :set_car, only: [:show, :edit, :update, :destroy]
  before_action :set_cars, only: [:new, :edit, :create, :update]

  # GET /cars
  def index
    @cars = Car.page params[:cars_page]
  end

  # GET /cars/1
  def show
    @client = @car.client
    @orders = @car.orders.page params[:orders_page]
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
  end

  # POST /cars
  def create
    @car = Car.new(car_params)

    if @car.save
      redirect_to @car, notice: 'Car was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /cars/1
  def update
    if @car.update(car_params)
      redirect_to @car, notice: 'Car was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /cars/1
  def destroy
    @car.destroy
    redirect_to cars_url, notice: 'Car was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    def set_cars
      @cars = Car.all
    end
    # Only allow a trusted parameter "white list" through.
    def car_params
      params.require(:car).permit(:client_id,
                                  :brand, :model, :state_number,
                                  :vin, :year, :mileage,
                                  :engine_number, :engine_type, :engine_capacity,
                                  :title, :content)
    end
end
