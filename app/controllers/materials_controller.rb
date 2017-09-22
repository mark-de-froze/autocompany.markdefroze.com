class MaterialsController < AuthenticateController
  load_and_authorize_resource

  before_action :set_materials
  before_action :set_material, only: [:show, :edit, :update, :destroy]

  # GET orders/1/materials
  def index
    @materials = @order.materials
  end

  # GET orders/1/materials/1
  def show
  end

  # GET orders/1/materials/new
  def new
    @material = @order.materials.build
  end

  # GET orders/1/materials/1/edit
  def edit
  end

  # POST orders/1/materials
  def create
    @material = @order.materials.build(material_params)

    if @material.save
      redirect_to(@order, notice: 'Material was successfully created.')
    else
      render action: 'new'
    end
  end

  # PUT orders/1/materials/1
  def update
    if @material.update(material_params)
      redirect_to(@order, notice: 'Material was successfully updated.')
    else
      render action: 'edit'
    end
  end

  # DELETE orders/1/materials/1
  def destroy
    @material.destroy

    redirect_to @order
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_materials
      @order_id = params[:order_id]
      @order = Order.find(@order_id)
    end

    def set_material
      @material = @order.materials.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def material_params
      params.require(:material).permit(:title, :price, :storable_id, :storable_type, :quantity)
    end
end
