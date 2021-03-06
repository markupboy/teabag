module Teabag::Generators
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path("../", __FILE__)

    desc "Installs the Teabag initializer into your application."

    def copy_initializer
      copy_file "templates/initializer.rb", "config/initializers/teabag.rb"
    end

    def create_structure
      empty_directory "spec/javascripts/support"
      empty_directory "spec/javascripts/fixtures"
    end

    def copy_spec_helper
      copy_file "templates/spec_helper.js", "spec/javascripts/spec_helper.js"
    end

    def display_readme
      readme "POST_INSTALL" if behavior == :invoke
    end
  end
end
