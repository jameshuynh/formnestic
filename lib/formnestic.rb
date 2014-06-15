# encoding: utf-8
require 'formtastic/engine' if defined?(::Rails)
require 'formtastic/helpers'
require 'formtastic'
module Formnestic
  extend ActiveSupport::Autoload
  autoload :Helpers, File.join(File.dirname(__FILE__), 'formnestic', 'helpers')
  autoload :FormBuilder, File.join(File.dirname(__FILE__), 'formnestic', 'form_builder')
  
  include Formnestic::Helpers  
  
  Formtastic::FormBuilder.send(:alias_method, :formtastic_semantic_fields_for, :semantic_fields_for)
  Formtastic::FormBuilder.send(:include, Formnestic::FormBuilder)
  Formtastic::FormBuilder.class_eval do
    def semantic_fields_for(record_or_name_or_array, *args, &block)
      options = args.dup.extract_options!
      if options[:display_type] == 'table'       
        formnestic_table_semantic_fields_for(record_or_name_or_array, *args, &block)
      else
        formtastic_semantic_fields_for(record_or_name_or_array, *args, &block)
      end
    end    
  end
end