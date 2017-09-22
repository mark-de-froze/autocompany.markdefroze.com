class HistoriesController < AuthenticateController
  load_and_authorize_resource

  before_action :set_history, only: [:show, :edit, :update, :destroy]
  before_action :set_trackable

  # GET /histories
  def index
    @histories = @trackable.histories
  end

  # GET /histories/1
  def show

  end

  # GET /histories/new
  def new
    @history = History.new
    @history.code = @trackable.code
    @history.price = @trackable.price
    @history.quantity = 1
  end

  # GET /histories/1/edit
  def edit
  end

  # POST /histories
  def create
    @history = @trackable.histories.build(history_params)

    if @history.save
      redirect_to [@trackable,History], notice: 'History was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /histories/1
  def update
    if @history.update(history_params)
      redirect_to [@trackable,History], notice: 'History was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /histories/1
  def destroy
    @history.destroy
    redirect_to [@trackable,History], notice: 'History was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_history
      @history = History.find(params[:id])
    end

    def set_trackable
      @trackable = find_trackable
    end

    # Only allow a trusted parameter "white list" through.
    def history_params
      params.require(:history).permit(:title, :price, :code, :quantity, :status)
    end

    def find_trackable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return $1.classify.constantize.find(value)
        end
      end
      nil
    end
end
