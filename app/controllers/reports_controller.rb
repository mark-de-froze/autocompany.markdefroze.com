class ReportsController < AuthenticateController

  def index
    @clients = Client.all

    @orders = Order.page params[:page]
  end
end
