# Route Tractor [![Code Climate](https://codeclimate.com/github/wkirschbaum/route_tractor.png)](https://codeclimate.com/github/wkirschbaum/route_tractor)

## Description
This gem generates RSpec tests for Rails routes.

## Usage
The gem provides a rake task that will generate a file containing tests for each of the route that your Rails application has.

    rake route_tractor:generate

Running this task will add a file in your spec/routes/ directory named all_routes_spec.rb

## Contributing to route_tractor

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Authors
[Wilhelm Kirschbaum](https://github.com/wkirschbaum)  
[Ile Eftimov](https://github.com/fteem)
