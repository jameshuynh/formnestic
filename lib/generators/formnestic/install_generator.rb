require 'rails/generators'

module Formnestic
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      source_root File.expand_path("../../../../", __FILE__)
      
      def copy_javascript        
        directory "app/assets/javascripts/formnestic", 'app/assets/javascripts/formnestic'
      end
      
      def copy_css
        directory "app/assets/stylesheets/formnestic", 'app/assets/stylesheets/formnestic'
      end
      
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
      
      def copy_locales
        copy_file "config/locales/formnestic.en.yml", "config/locales/formnestic.en.yml"
      end            
    end
  end
end
