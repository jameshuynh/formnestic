module Formnestic
  module FormBuilder
    module ListFormBuilder
      include Formnestic::FormBuilder::BaseBuilder
      def formnestic_list_semantic_fields_for(record_or_name_or_array, *args, &block)
        options = args.dup.extract_options!
        
        formnestic_add_rows_counter_related_attributes
        existing_rows = formtastic_semantic_fields_for(record_or_name_or_array, *args, &block)
        contents = [template.content_tag(:div, existing_rows, class: "formnestic-list-entries-container")]
        
        options[:min_entry] ||= -1
        options[:max_entry] ||= -1
        
        entity_name = I18n.t("activerecord.models.#{record_or_name_or_array.to_s.singularize}", default: record_or_name_or_array.to_s.singularize)
        options[:min_entry_alert_message] = options[:min_entry] != -1 ? (options[:min_entry_alert_message] ||
               I18n.t('formnestic.labels.there_must_be_at_least_a_number_of_entries', {
                 count: (options[:min_entry]), 
                 entity_singular: entity_name, 
                 entity_plural: entity_name.pluralize})) : ''
                 
        if options[:row_addable]
          add_new_record_button_row = template.content_tag(:div, formnestic_link_to_add_fields_with_content(record_or_name_or_array, *args, &block), class: "formnestic-list-new-entry-link-container")
          contents.push(add_new_record_button_row)
        end
        
        options[:class] = [options[:class], "formnestic-nested-model-container"].compact.join
        template.content_tag(:div,
          contents.join.html_safe,
          options.except(:builder, :parent, :name, :parent_builder, :display_type, :row_removable, :new_record_link_label, :child_index)
        )
      end            
    end
  end
end
