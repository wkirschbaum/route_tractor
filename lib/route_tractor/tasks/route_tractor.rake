require 'route_tractor/generator'

namespace 'route_tractor' do
  desc "Generate route specs"
  task :generate => :environment do
    RouteTractor::Generator.generate
  end
end
