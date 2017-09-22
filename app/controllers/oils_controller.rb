class OilsController < AuthenticateController
  load_and_authorize_resource

  before_action :set_oil, only: [:show, :edit, :update, :destroy]

  # GET /oils
  def index
    @oils = Oil.all.page params[:page]
  end

  # GET /oils/1
  def show
  end

  # GET /oils/new
  def new
    @oil = Oil.new
  end

  # GET /oils/1/edit
  def edit
  end

  # POST /oils
  def create
    @oil = Oil.new(oil_params)

    if @oil.save
      redirect_to @oil, notice: 'Oil was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /oils/1
  def update
    if @oil.update(oil_params)
      redirect_to @oil, notice: 'Oil was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /oils/1
  def destroy
    @oil.destroy
    redirect_to oils_url, notice: 'Oil was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_oil
      @oil = Oil.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def oil_params
      params.require(:oil).permit(:title, :price, :code, :unit, :storable_id, :storable_type, :quantity, :status, :total)
    end
end
