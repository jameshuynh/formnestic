module Formnestic
  module FormBuilder
    module BaseBuilder
      
      def formnestic_add_rows_counter_related_attributes
        instance_eval do
          instance_variable_set("@rows_counter", 0)        
          def rows_counter
            return @rows_counter
          end
        
          def increase_rows_counter
            @rows_counter += 1
          end
        end        
      end
      
      def formnestic_link_to_add_fields_with_content(record_or_name_or_array, *args, &block)
        new_object = self.object.class.reflect_on_association(record_or_name_or_array).klass.new
        options = args.dup.extract_options!
        options[:max_entry] ||= -1
        duplicate_args = args.dup
        duplicate_args = duplicate_args.unshift(new_object)
        new_record_form_options = duplicate_args.extract_options!
        rows_counter = self.rows_counter
        new_record_form_options[:child_index] = "new_#{record_or_name_or_array}"
        new_record_form_content = formtastic_semantic_fields_for(record_or_name_or_array, *(duplicate_args << new_record_form_options), &block)
        link_title = options[:new_record_link_label] || I18n.t("formnestic.labels.add_new_entry")        
        javascript_fn_to_call = options[:display_type] == 'table' ? 'addNewTableEntry' : 'addNewListEntry'
        
        template.link_to_function(link_title, \
          "Formnestic.#{javascript_fn_to_call}(this, \"#{record_or_name_or_array}\", \"#{escape_javascript(new_record_form_content)}\")", \
            "class" => ["formnestic-add-row-field-link", options[:new_record_link_class], (options[:max_entry] != -1 and rows_counter >= options[:max_entry]) ? "hidden" : nil].compact.join(" "))
      
      end
    end
  end
end