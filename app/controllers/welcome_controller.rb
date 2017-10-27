class WelcomeController < ApplicationController
  layout 'landing'

  def index
    @services = Service.all

    @orders = Order.all.size
    @clients = Client.all.size
    @cars = Car.all.size
    @workers = Worker.all.size
  end
end
