# encoding: utf-8
require 'formnestic/engine' if defined?(::Rails)
require 'formtastic/helpers'
require 'formtastic'
module Formnestic
  extend ActiveSupport::Autoload
  autoload :Helpers, File.join(File.dirname(__FILE__), 'formnestic', 'helpers')
  autoload :FormBuilder, File.join(File.dirname(__FILE__), 'formnestic', 'form_builder')
  autoload :Inputs, File.join(File.dirname(__FILE__), 'formnestic', 'inputs')  
  autoload :FormtasticExtensions, File.join(File.dirname(__FILE__), 'formnestic', 'formtastic_extensions')  
  
  include Formnestic::Helpers  
  include Formnestic::Inputs::Base    
  extend Formnestic::FormtasticExtensions
  
  extend_form_builder
  extend_form_inputs
  extend_datetime_related_inputs
  extend_boolean_input
  
end