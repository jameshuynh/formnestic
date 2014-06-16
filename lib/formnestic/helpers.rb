module Formnestic
  # @private
  module Helpers
    autoload :InputsHelper, File.join(File.dirname(__FILE__), 'helpers', 'inputs_helper')
    autoload :NestedModelTableHelper, File.join(File.dirname(__FILE__), 'helpers', 'nested_model_table_helper')
    Formtastic::FormBuilder.send(:alias_method, :formtastic_inputs, :inputs)
    Formtastic::FormBuilder.send(:include, Formnestic::Helpers::InputsHelper)
    Formtastic::FormBuilder.send(:include, Formnestic::Helpers::NestedModelTableHelper)
  end
end