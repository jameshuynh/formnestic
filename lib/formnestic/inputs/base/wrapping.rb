module Formnestic
  module Inputs
    module Base
      module Wrapping
        def input_wrapping(&block)
          if self.builder.options[:display_type] == "table"
            if [
              "Formtastic::Inputs::DateSelectInput", 
              "Formtastic::Inputs::TimeSelectInput", 
              "Formtastic::Inputs::DateTimeSelectInput",
              "Formtastic::Inputs::TimeInput", 
              "Formtastic::Inputs::DateInput", 
            ].index(self.class.to_s)
              table_date_select_input_wrapping(&block)
            else
              table_input_wrapping(&block)
            end
          else
            formtastic_input_wrapping(&block)
          end
        end
  
        def table_date_select_input_wrapping(&block)
          self.builder.options[:parent_builder].add_table_header(self.attributized_method_name, self.class, label_text)
          template.content_tag(:td, 
            template.content_tag(:div, [
              template.capture(&block), error_html, hint_html].join("\n").html_safe, 
            class: "table-date-select-container"), wrapper_html_options
          )
        end
              
        def table_input_wrapping(&block)
          self.builder.options[:parent_builder].add_table_header(self.attributized_method_name, self.class, label_text)
          template.content_tag(:td, 
            [template.capture(&block), error_html, hint_html].join("\n").html_safe, 
            wrapper_html_options
          )
        end          
      end
    end
  end
end