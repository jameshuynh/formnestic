module Formnestic
  # @private
  module Helpers
    autoload :InputsHelper, File.join(File.dirname(__FILE__), 'helpers', 'inputs_helper')
    Formtastic::FormBuilder.send(:alias_method, :formtastic_inputs, :inputs)
    Formtastic::FormBuilder.send(:include, Formnestic::Helpers::InputsHelper)
  end
end