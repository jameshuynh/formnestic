require 'rails/generators'

module Formnestic
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      def inject_javascript
        append_to_file 'app/assets/javascripts/application.js' do
          out = "\n"
          out << "//= require formnestic/formnestic"
        end
      end
      
      def inject_css
        append_to_file 'app/assets/stylesheets/application.css' do
          out = "\n"
          out << "/* *= require formnestic/formnestic */"
        end
        
      end      
    end
  end
end
