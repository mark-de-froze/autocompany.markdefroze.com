class TasksController < AuthenticateController
  load_and_authorize_resource

  before_action :set_tasks
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET orders/1/tasks
  def index
    @tasks = @order.tasks
  end

  # GET orders/1/tasks/1
  def show
  end

  # GET orders/1/tasks/new
  def new
    @task = @order.tasks.build
  end

  # GET orders/1/tasks/1/edit
  def edit
  end

  # POST orders/1/tasks
  def create
    @task = @order.tasks.build(task_params)

    if @task.save
      redirect_to(@order, notice: 'Task was successfully created.')
    else
      render :new
    end
  end

  # PUT orders/1/tasks/1
  def update
    if @task.update_attributes(task_params)
      redirect_to(@order, notice: 'Task was successfully updated.')
    else
      render :edit
    end
  end

  # DELETE orders/1/tasks/1
  def destroy
    @task.destroy

    redirect_to @order
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tasks
      @order_id = params[:order_id]
      @order = Order.find(@order_id)
    end

    def set_task
      @task = @order.tasks.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:service_id, :job_id, :worker_id, :price, :finished_at)
    end
end
