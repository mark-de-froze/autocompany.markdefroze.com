class Reports::OrdersController < AuthenticateController

  def index
    @date = params[:date]

    @start_date = Date.parse(@date) if params[:date]

    @client = params[:client]

    @orders = Order.where(status: :closed)

    @title = 'List of reports by orders'

    unless @start_date || (@client && params[:all])
      @title << ' by month'
      first_year = @orders.order(:created_at).first.created_at.strftime('%Y').to_i
      end_year = Date.today.year
      @years = [first_year]
      @years = first_year..end_year if first_year < end_year
    end

    if @client
      @orders = @orders.where(client_id: @client)
      @title << ' for ' + Client.find(@client).to_label
    end

    if @start_date
      @title << ' for ' + @start_date.strftime('%B, %Y')

      end_date = @start_date.end_of_month

      @orders = @orders.month(@start_date,end_date)
    end

    if @start_date || (@client && params[:all])
      @total_amount_tasks = @total_amount_materials = @total_total = @total_tax = @total_total_with_tax  = 0
      @orders = @orders.all

      @orders.each do |order|
        @total_amount_tasks += order.calculate_amount_tasks
        @total_amount_materials += order.calculate_amount_materials
        @total_total += order.calculate_total
        @total_tax += order.calculate_tax
        @total_total_with_tax += order.calculate_total_with_tax
      end
    end
  end

  def show
    @order = Order.where(status: :closed).find(params[:id])
  end
end
