require 'rails'

module RouteTractor 
  class Generator
    REGEX = /([A-Z]+\s+)?(\/.*)/

    def self.generate

      FileUtils.mkdir_p('spec/routing/')

      # prepare spec file
      self.inject_header_code

      puts "### Processing routes data..."

      self.load_routes

      # Finish-up spec file
      self.inject_footer_code

      puts "### Finished!"
      puts "### Bye!"
    end

    def self.inject_header_code
      header_text = "require \"spec_helper\"\ndescribe \"All routes\" do\n"
      system('touch spec/routing/all_routes_spec.rb')
      system("echo '#{header_text}' > spec/routing/all_routes_spec.rb")
    end

    def self.inject_footer_code
      footer_text = "end"
      system("echo '#{footer_text}' >> spec/routing/all_routes_spec.rb")
    end

    def self.generate_route_spec(http_verb, route, hash)
      spec_str = "it { { :#{http_verb} => \"#{route}\" }.should route_to#{hash} }"
      system("echo '#{spec_str}' >> spec/routing/all_routes_spec.rb")
    end

    def self.load_routes
      puts "### Loading routes..."

      Rails.application.routes.routes.each do |route|
        match_data = REGEX.match(route.to_s)
        next unless match_data
        verb = match_data[1].strip

        path = match_data[2].strip.gsub(/\(.:.*\)/, '').gsub(/:\w*/, '1').split[0]

        if verb == 'ANY'
          ["POST", "PUT", "GET", "DELETE"].each do |verb_variation| 
            routing_options = Rails.application.routes.recognize_path(path, :method => verb_variation).to_s.gsub(/{/, '(').gsub(/}/, ')')
            verb_variation.downcase!
            generate_route_spec(verb_variation.downcase, path, routing_options)
          end
        else
          routing_options = Rails.application.routes.recognize_path(path, :method => verb).to_s.gsub(/{/, '(').gsub(/}/, ')')
          verb.downcase!
          generate_route_spec(verb.downcase, path, routing_options)
        end
      end
    end
  end
end
