require 'route_tractor'

module RouteTractor
  class Railtie < Rails::Railtie
    railtie_name :route_tractor

    rake_tasks do
      load "route_tractor/tasks/route_tractor.rake"
    end
  end
end