module Formnestic
  module FormBuilder
    include ActionView::Helpers::JavaScriptHelper

    autoload :BaseBuilder, File.join(File.dirname(__FILE__), 'form_builder', 'base_builder')
    autoload :TableFormBuilder, File.join(File.dirname(__FILE__), 'form_builder', 'table_form_builder')
    autoload :ListFormBuilder, File.join(File.dirname(__FILE__), 'form_builder', 'list_form_builder')

    include Formnestic::FormBuilder::TableFormBuilder
    include Formnestic::FormBuilder::ListFormBuilder
  end
end
