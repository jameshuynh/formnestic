module Formnestic
  module Inputs
    module Base
      module Labelling
        def render_label?
          if self.builder.options[:display_type] == "table"
            false
          else
            formtastic_render_label?
          end
        end        
      end
    end
  end
end