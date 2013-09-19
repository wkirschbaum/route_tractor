require 'rails'

module RouteTractor

  class Builder
    REGEX = /([A-Z]+\s+)?(\/.*)/

    def initialize(file)
      @file = file
    end

    def build_routes
      load_routes do |verb, path, routing_options|
        spec_string = "\tit { { :#{verb} => \"#{path}\" }.should route_to#{routing_options} }\n"
        @file.write(spec_string)
      end
    end

    def build_header
      @file.write("require \"spec_helper\"\ndescribe \"All routes\" do\n")
    end

    def build_footer
      @file.write("end")
    end

    private
    def load_routes
      Rails.application.routes.routes.each do |route|
        match_data = REGEX.match(route.to_s)

        next unless match_data

        verb = match_data[1].strip
        path = match_data[2].strip.gsub(/\(.:.*\)/, '').gsub(/:\w*/, '1').split[0]

        if verb == 'ANY'
          ["POST", "PUT", "GET", "DELETE"].each do |verb_variation|
            routing_options = Rails.application.routes.recognize_path(path, :method => verb_variation).to_s.gsub(/{/, '(').gsub(/}/, ')')
            verb_variation.downcase!
            yield verb_variation.downcase, path, routing_options
          end
        else
          routing_options = Rails.application.routes.recognize_path(path, :method => verb).to_s.gsub(/{/, '(').gsub(/}/, ')')
          verb.downcase!
          yield verb.downcase, path, routing_options
        end
      end
    end
  end

end
