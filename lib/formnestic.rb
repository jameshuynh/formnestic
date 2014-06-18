# encoding: utf-8
require 'formtastic/engine' if defined?(::Rails)
require 'formtastic/helpers'
require 'formtastic'
module Formnestic
  extend ActiveSupport::Autoload
  autoload :Helpers, File.join(File.dirname(__FILE__), 'formnestic', 'helpers')
  autoload :FormBuilder, File.join(File.dirname(__FILE__), 'formnestic', 'form_builder')
  autoload :Inputs, File.join(File.dirname(__FILE__), 'formnestic', 'inputs')  
  
  include Formnestic::Helpers  
  include Formnestic::Inputs::Base
  
  Formtastic::FormBuilder.send(:alias_method, :formtastic_semantic_fields_for, :semantic_fields_for)
  Formtastic::FormBuilder.send(:include, Formnestic::FormBuilder)
  Formtastic::Inputs::Base.send(:alias_method, :formtastic_input_wrapping, :input_wrapping)
  Formtastic::Inputs::Base.send(:include, Formnestic::Inputs::Base::Wrapping)
  
  Formtastic::Inputs::Base.send(:alias_method, :formtastic_render_label?, :render_label?)
  Formtastic::Inputs::Base.send(:include, Formnestic::Inputs::Base::Labelling)
  
  Formtastic::Inputs::DateSelectInput.send(:alias_method, :formtastic_fragment_label_html, :fragment_label_html)  
  Formtastic::Inputs::DatetimeInput.send(:alias_method, :formtastic_fragment_label_html, :fragment_label_html)  
  Formtastic::Inputs::TimeInput.send(:alias_method, :formtastic_fragment_label_html, :fragment_label_html)  
  Formtastic::Inputs::BooleanInput.send(:alias_method, :formtastic_label_text_with_embedded_checkbox, :label_text_with_embedded_checkbox)  
  
  Formtastic::Inputs::DateSelectInput.class_eval do
    def fragment_label_html(fragment)
      if self.builder.options[:display_type] == "table"
        "".html_safe
      else
        formtastic_fragment_label_html(fragment)
      end
    end
  end
  
  Formtastic::Inputs::DatetimeInput.class_eval do
    def fragment_label_html(fragment)
      if self.builder.options[:display_type] == "table"
        ""
      else
        formtastic_fragment_label_html(fragment)
      end
    end
  end
  
  Formtastic::Inputs::TimeInput.class_eval do
    def fragment_label_html(fragment)
      if self.builder.options[:display_type] == "table"
        ""
      else
        formtastic_fragment_label_html(fragment)
      end
    end
  end  
  
  Formtastic::Inputs::BooleanInput.class_eval do
    def label_text_with_embedded_checkbox
      if self.builder.options[:display_type] == 'table'
        check_box_html
      else
        formtastic_label_text_with_embedded_checkbox
      end
    end          
  end
  
  Formtastic::FormBuilder.class_eval do
    def semantic_fields_for(record_or_name_or_array, *args, &block)
      options = args.dup.extract_options!
      if options[:display_type] == 'table'       
        formnestic_table_semantic_fields_for(record_or_name_or_array, *args, &block)
      elsif options[:row_removable].present? or options[:row_addable].present?
        formnestic_list_semantic_fields_for(record_or_name_or_array, *args, &block)
      else
        formtastic_semantic_fields_for(record_or_name_or_array, *args, &block)
      end
    end    
  end
  
  if defined?(::Rails)
    class Engine < Rails::Engine
    end
  end
  
end