class Menu
  def self.all
    self.build
  end

  private

  def self.build
    menu = Hash.new
    Rails.application.routes.routes.map do |route|
      controller = route.defaults[:controller].to_s
      name = controller.gsub('/',' ').humanize
      unless controller.include?('rails') || controller.empty? || controller.include?('users/')
        menu['/'+controller] = name
      end
      menu
    end.uniq.slice(0)
  end
end
