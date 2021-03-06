class PartsController < AuthenticateController
  load_and_authorize_resource

  before_action :set_part, only: [:show, :edit, :update, :destroy]

  # GET /parts
  def index
    @parts = Part.all.page params[:page]
  end

  # GET /parts/1
  def show
  end

  # GET /parts/new
  def new
    @part = Part.new
  end

  # GET /parts/1/edit
  def edit
  end

  # POST /parts
  def create
    @part = Part.new(part_params)

    if @part.save
      redirect_to @part, notice: 'Part was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /parts/1
  def update
    if @part.update(part_params)
      redirect_to @part, notice: 'Part was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /parts/1
  def destroy
    @part.destroy
    redirect_to parts_url, notice: 'Part was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_part
      @part = Part.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def part_params
      params.require(:part).permit(:title, :price, :code, :unit, :storable_id, :storable_type, :quantity)
    end
end
