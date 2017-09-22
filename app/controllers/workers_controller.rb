class WorkersController < AuthenticateController
  load_and_authorize_resource

  before_action :set_worker, only: [:show, :edit, :update, :destroy]
  before_action :set_services, only: [:new, :edit, :update, :create]

  # GET /workers
  def index
    @workers = Worker.page params[:page]
  end

  # GET /workers/1
  def show
    @orders = @worker.orders.page params[:orders_page]
    @tasks = @worker.tasks.page params[:tasks_page]
  end

  # GET /workers/new
  def new
    @worker = Worker.new
  end

  # GET /workers/1/edit
  def edit
  end

  # POST /workers
  def create
    @worker = Worker.new(worker_params)

    if @worker.save
      redirect_to @worker, notice: 'Worker was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /workers/1
  def update
    if @worker.update(worker_params)
      redirect_to @worker, notice: 'Worker was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /workers/1
  def destroy
    @worker.destroy
    redirect_to workers_url, notice: 'Worker was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_worker
      @worker = Worker.find(params[:id])
    end

    def set_services
      @services = Service.all
    end

    # Only allow a trusted parameter "white list" through.
    def worker_params
      params.require(:worker).permit(:title, :content, :user_id, { service_ids:[] })
    end
end
