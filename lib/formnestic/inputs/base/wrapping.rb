module Formnestic
  module Inputs
    module Base
      module Wrapping
        def input_wrapping(&block)
          if self.builder.options[:display_type] == "table"
            if self.instance_of?(Formtastic::Inputs::SelectInput)
              select_input_wrapping(&block)
            elsif self.instance_of?(Formtastic::Inputs::BooleanInput)
              boolean_input_wrapping(&block)  
            elsif self.instance_of?(Formtastic::Inputs::DateSelectInput)
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
          template.content_tag(:td, template.content_tag(:div, [template.capture(&block), error_html, hint_html].join("\n").html_safe, class: "table-date-select-container"), wrapper_html_options)
        end
              
        def table_input_wrapping(&block)
          self.builder.options[:parent_builder].add_table_header(self.attributized_method_name, self.class, label_text)
          template.content_tag(:td, 
            [template.capture(&block), error_html, hint_html].join("\n").html_safe, 
            wrapper_html_options
          )
        end
        
        def boolean_input_wrapping(&block)
          self.builder.options[:parent_builder].add_table_header(self.attributized_method_name, self.class, label_text)
          template.content_tag(:td, 
            [template.capture(&block), error_html, hint_html].join("\n").html_safe, 
            wrapper_html_options
          )
        end
  
        def select_input_wrapping(&block)

          self.builder.options[:parent_builder].add_table_header(self.attributized_method_name, self.class, label_text)
          template.content_tag(:td, 
            [template.capture(&block), error_html, hint_html, extra_input_for_other_in_select].join("\n").html_safe, 
            wrapper_html_options
          )
        end
  
        def extra_input_for_other_in_select
          
          extra_input = ""        
          if self.options[:other_input_field_name].blank? == false and self.options[:other_trigger_value].blank? == false
            extra_class_for_input = "hidden"

            gsub_attribute_name = (association_primary_key || sanitized_method_name).to_s
            actual_value = if self.object.send(self.method).class < ActiveRecord::Base
              self.object.send(self.method).id.to_s        
            else
              self.object.send(self.method).to_s        
            end

            extra_class_for_input = "" if actual_value == self.options[:other_trigger_value].to_s
            extra_input = template.tag(:input, name: self.input_html_options[:name].gsub("[#{gsub_attribute_name}]", "[#{self.options[:other_input_field_name].to_s}]"), class: "other #{extra_class_for_input}", value: self.object.send(self.options[:other_input_field_name]))
            extra_input += template.javascript_tag(%Q{
              $('##{self.dom_id}').change(function() { 
                if($(this).val() == '#{self.options[:other_trigger_value]}') {
                  $(this).parent().find('input.other').removeClass('hidden').focus();
                }//end if
                else {
                  $(this).parent().find('input.other').addClass('hidden');
                }
              });})
          end
          return extra_input
        end  
      end
    end
  end
end