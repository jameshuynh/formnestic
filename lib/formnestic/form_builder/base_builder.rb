module Formnestic
  module FormBuilder
    module BaseBuilder
      def formnestic_min_entry_alert_message(record_or_name_or_array, min_entry)
        entity_name = I18n.t("activerecord.models.#{record_or_name_or_array.to_s.singularize}", default: record_or_name_or_array.to_s.tr('_', ' ').singularize.singularize)
        min_entry != -1 ? (options[:min_entry_alert_message] ||
             I18n.t('formnestic.labels.there_must_be_at_least_a_number_of_entries', count: min_entry,
                                                                                    entity_singular: entity_name,
                                                                                    entity_plural: entity_name.pluralize)) : ''
      end

      def formnestic_add_rows_counter_related_attributes
        instance_eval do
          instance_variable_set('@rows_counter', 0)
          def rows_counter
            @rows_counter
          end

          def increase_rows_counter
            @rows_counter += 1
          end
        end
      end

      def formnestic_link_to_add_fields_with_content(record_or_name_or_array, *args, &block)
        new_object = object.class.reflect_on_association(record_or_name_or_array).klass.new
        options = args.dup.extract_options!
        options[:max_entry] ||= -1
        duplicate_args = args.dup
        duplicate_args = duplicate_args.unshift(new_object)
        new_record_form_options = duplicate_args.extract_options!
        rows_counter = self.rows_counter
        new_record_form_options[:child_index] = "new_#{record_or_name_or_array}"
        new_record_form_content = formtastic_semantic_fields_for(record_or_name_or_array, *(duplicate_args << new_record_form_options), &block)
        link_title = options[:new_record_link_label] || I18n.t('formnestic.labels.add_new_entry')
        javascript_fn_to_call = js_call_for_nested_model_display_type(options[:display_type])

        template.link_to(link_title, '#', onclick:
          "Formnestic.#{javascript_fn_to_call}(this, \"#{record_or_name_or_array}\", \"#{escape_javascript(new_record_form_content)}\"); return false;", \
                                          'class' => ['formnestic-add-row-field-link', options[:new_record_link_class], (options[:max_entry] != -1) && (rows_counter >= options[:max_entry]) ? 'formnestic-hidden' : nil].compact.join(' '))
      end

      def js_call_for_nested_model_display_type(display_type)
        if display_type == 'table'
          'addNewTableEntry'
        else
          'addNewListEntry'
        end
      end
    end
  end
end
