class ReportsController < AuthenticateController

  def index
    @clients = Client.all

    @orders = Order.where(status: :closed).page params[:page]
  end
end
