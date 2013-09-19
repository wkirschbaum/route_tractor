require 'rails'

module RouteTractor
  class Generator
    FILE_PATH = "spec/routing/all_routes_spec.rb"

    def self.generate

      # Create the spec/routing/ directory if it doesn't exist
      FileUtils.mkdir_p('spec/routing/')

      unless File.exists?(FILE_PATH)
        FileUtils.touch(FILE_PATH)
      else
        puts "A file with the name spec/routing/all_routes_spec.rb has been found. Do you want to override it? [y/n]"
        input = STDIN.gets.downcase
        unless input == 'y'
          puts "### Done!"
          return
        end
      end

      # prepare spec file
      puts "### Building spec file..."
      spec_file = File.open('spec/routing/all_routes_spec.rb', 'w') do |f|
        builder = Builder.new(f)

        builder.build_header
        builder.build_routes
        builder.build_footer
      end

      puts "### Done!"
    end
  end

end
