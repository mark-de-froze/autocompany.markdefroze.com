class DashboardController < AuthenticateController
  def index
    @oils_barrels = Oil.where(:unit => :liter).where('total > 1')

    @oils = Oil.where('quantity < 5').all
    @parts = Part.where('quantity < 5')

    @orders = Order.where(:status => :opened).page params[:orders_page]

    @counters = [
        {
            'title' => 'Orders',
            'label' => '',
            'counter' => Order.all.size,
            'text' => 'Total orders',
        },
        {
            'title' => 'Clients',
            'label' => '',
            'counter' => Client.all.size,
            'text' => 'Total clients',
        },
        {
            'title' => 'Cars',
            'label' => '',
            'counter' => Car.all.size,
            'text' => 'Total cars',
        },
        {
            'title' => 'Workers',
            'label' => '',
            'counter' => Worker.all.size,
            'text' => 'Total workers',
        },
    ]
  end
end
