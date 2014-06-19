module Formnestic
  module FormBuilder
    module TableFormBuilder
      include Formnestic::FormBuilder::BaseBuilder
      
      def formnestic_table_semantic_fields_for(record_or_name_or_array, *args, &block)
        options = args.dup.extract_options!
        options[:parent_builder] ||= self 
        
        formnestic_add_table_headers_form_attributes
        formnestic_add_rows_counter_related_attributes
                      
        contents = [formtastic_semantic_fields_for(record_or_name_or_array, *args, &block)]
        contents.push(formnestic_add_new_record_button_row(record_or_name_or_array, *args, &block)) if options[:row_addable]
        options[:class] = ["formnestic-table-inputs formnestic-nested-model", options[:class]].compact.join(" ")
        options[:min_entry] ||= -1
        options[:max_entry] ||= -1      
        options[:min_entry_alert_message] = formnestic_min_entry_alert_message(record_or_name_or_array)
               
        ### Finally, wrap everything inside a table tag
        template.content_tag(:table, [
            formnestic_table_header(options, record_or_name_or_array), # table header
            template.content_tag(:tbody, Formtastic::Util.html_safe(contents.join)) # table body
          ].join.html_safe,
          options.except(:builder, :parent, :name, :parent_builder, :display_type, :row_removable, :new_record_link_label)
        )
      end
    
      def formnestic_add_table_headers_form_attributes
        instance_eval do
          instance_variable_set("@table_headers", [])
          def table_headers
            return @table_headers
          end
        
          def add_table_header(column_name, class_name, label_text)
            if @table_headers.detect{|x| x[:attr] == column_name}.nil?
              @table_headers.push({attr: column_name, class: class_name.to_s.tableize.gsub("formtastic/inputs/", "").gsub("_", "-").gsub("-inputs", ""), label_text: label_text})
            end
          end
        end
      end
      
      def formnestic_add_new_record_button_row(record_or_name_or_array, *args, &block)
        return template.content_tag(:tr, template.content_tag(:td, formnestic_link_to_add_fields_with_content(record_or_name_or_array, *args, &block), {colspan: "100%"}), class: "formnestic-table-no-border")
      end
      
      def formnestic_min_entry_alert_message(record_or_name_or_array)
        entity_name = I18n.t("activerecord.models.#{record_or_name_or_array.to_s.singularize}", default: record_or_name_or_array.to_s.singularize)
        return options[:min_entry] != -1 ? (options[:min_entry_alert_message] ||
               I18n.t('formnestic.labels.there_must_be_at_least_a_number_of_entries', {
                 count: (options[:min_entry]), 
                 entity_singular: entity_name, 
                 entity_plural: entity_name.pluralize})) : ''
        
      end
          
      def formnestic_table_header(header_options, record_or_name_or_array)        
        association_name = record_or_name_or_array.is_a?(Array) ? record_or_name_or_array[0] : record_or_name_or_array
        thead_contents = if header_options[:thead]
          formnestic_thead_contents_from_arguments(header_options[:thead])
        else
          formnestic_thead_contents_from_inputs(header_options[:row_removable])
        end        
        return template.content_tag(:thead, thead_contents.join.html_safe)
      end
      
      def formnestic_thead_contents_from_inputs(row_removable)
        tr_content_arr = []
        table_headers.each do |header|
          tr_content_arr.push(template.content_tag(:th, header[:label_text], class: header[:class]))
        end
        tr_content_arr.push(template.content_tag(:th, "", class: "formnestic-minus-thead")) if row_removable
        [template.content_tag(:tr, tr_content_arr.join.html_safe)]
      end
      
      def formnestic_thead_contents_from_arguments(theads)
        thead_contents = []
        theads.each do |el_arr|
    		  tr_content_arr = []
    		  el_arr.each do |el|
            tr_content_arr.push(template.content_tag(:th, el[:attr].blank? == false ? ::I18n.t("activerecord.attributes.#{association_name.to_s.singularize}.#{el[:attr]}") : "", el[:html_options]))
    		  end
    		  thead_contents.push(template.content_tag(:tr, tr_content_arr.join.html_safe))
    		end
        thead_contents
      end
    end
  end
end