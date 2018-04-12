module Formnestic
  module FormBuilder
    module ListFormBuilder
      include Formnestic::FormBuilder::BaseBuilder
      def formnestic_list_semantic_fields_for(record_or_name_or_array, *args, &block)
        options = args.dup.extract_options!

        formnestic_add_rows_counter_related_attributes
        existing_rows = formtastic_semantic_fields_for(record_or_name_or_array, *args, &block)
        contents = [template.content_tag(:div, existing_rows, class: 'formnestic-list-entries-container')]

        options[:min_entry] ||= -1
        options[:max_entry] ||= -1

        options[:min_entry_alert_message] = formnestic_min_entry_alert_message(record_or_name_or_array, options[:min_entry])
        contents.push(formnestic_add_new_record_button_row_for_list_form(record_or_name_or_array, *args, &block)) if options[:row_addable]
        options[:class] = [options[:class], 'formnestic-nested-model-container'].compact.join

        template.content_tag(:div,
                             contents.join.html_safe,
                             options.except(:builder, :parent, :name, :parent_builder, :display_type, :row_removable, :new_record_link_label, :child_index))
      end

      def formnestic_add_new_record_button_row_for_list_form(record_or_name_or_array, *args, &block)
        template.content_tag(:div, formnestic_link_to_add_fields_with_content(record_or_name_or_array, *args, &block), class: 'formnestic-list-new-entry-link-container')
      end
    end
  end
end
