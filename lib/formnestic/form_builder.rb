module Formnestic
  module FormBuilder    
    include ActionView::Helpers::JavaScriptHelper
    def formnestic_table_semantic_fields_for(record_or_name_or_array, *args, &block)
      options = args.dup.extract_options!
      options[:parent_builder] ||= self 
      formnestic_add_table_form_attributes
      
      existing_rows = formtastic_semantic_fields_for(record_or_name_or_array, *args, &block)
      contents = [existing_rows]
      if options[:row_addable]
        add_new_record_button_row = template.content_tag(:tr, template.content_tag(:td, formnestic_link_to_add_fields_with_content(record_or_name_or_array, *args, &block), {colspan: "100%"}), class: "formnestic-table-no-border")
        contents.push(add_new_record_button_row)
      end
          
      table_header = formnestic_table_header(options, record_or_name_or_array)
            
      options[:class] = options[:class].blank? ? "formnestic-table-inputs formnestic-nested-model" : "#{html_options[:class]} formnestic-table-inputs formnestic-nested-model"
      
      options[:min_entry] ||= -1
      options[:max_entry] ||= -1
      
      entity_name = I18n.t("activerecord.models.#{record_or_name_or_array.to_s.singularize}", default: record_or_name_or_array.to_s.singularize)
      options[:min_entry_alert_message] = options[:min_entry] != -1 ? (options[:min_entry_alert_message] ||
             I18n.t('formnestic.labels.there_must_be_at_least_a_number_of_entries', {
               count: (options[:min_entry]), 
               entity_singular: entity_name, 
               entity_plural: entity_name.pluralize})) : ''
               
      template.content_tag(:table,
        [table_header, template.content_tag(:tbody, Formtastic::Util.html_safe(contents.join))].join.html_safe,
        options.except(:builder, :parent, :name, :parent_builder, :display_type, :row_removable, :new_record_link_label)
      )
    end
    
    def formnestic_add_table_form_attributes
      instance_eval do
        instance_variable_set("@table_headers", [])
        instance_variable_set("@rows_counter", 0)
        def table_headers
          return @table_headers
        end
        
        def add_table_header(column_name, class_name, label_text)
          if @table_headers.detect{|x| x[:attr] == column_name}.nil?
            @table_headers.push({attr: column_name, class: class_name.to_s.tableize.gsub("formtastic/inputs/", "").gsub("_", "-").gsub("-inputs", ""), label_text: label_text})
          end
        end
        
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
      options[:parent_builder] ||= self
      rows_counter = self.rows_counter
      new_record_form_options[:child_index] = "new_#{record_or_name_or_array}"
      new_record_form_content = formtastic_semantic_fields_for(record_or_name_or_array, *(duplicate_args << new_record_form_options), &block)
      link_title = options[:new_record_link_label] || I18n.t("formnestic.labels.add_new_entry")
      template.link_to_function(link_title, \
        "Formnestic.addNewTableEntry(this, \"#{record_or_name_or_array}\", \"#{escape_javascript(new_record_form_content)}\")", \
          "class" => ["formnestic-add-row-field-link", options[:new_record_link_class], rows_counter >= options[:max_entry] ? "hidden" : nil].compact.join(" "))
      
    end
        
    def formnestic_table_header(header_options, record_or_name_or_array)        
      thead_contents = []
      tr_content_arr = []
      association_name = record_or_name_or_array.is_a?(Array) ? record_or_name_or_array[0] : record_or_name_or_array
      if header_options[:thead]
        args[0][:thead].each do |el_arr|
    		  tr_content_arr = []
    		  el_arr.each do |el|
            tr_content_arr.push(template.content_tag(:th, el[:attr].blank? == false ? ::I18n.t("activerecord.attributes.#{association_name.to_s.singularize}.#{el[:attr]}") : "", el[:html_options]))
    		  end
    		  thead_contents.push(template.content_tag(:tr, tr_content_arr.join.html_safe))
    		end
      else
        table_headers.each do |header|
          tr_content_arr.push(template.content_tag(:th, header[:label_text], class: header[:class]))
         end
         if header_options[:row_removable]
           tr_content_arr.push(template.content_tag(:th, "", class: "formnestic-minus-thead"))
         end
         thead_contents = [template.content_tag(:tr, tr_content_arr.join.html_safe)]
      end
      return template.content_tag(:thead, thead_contents.join.html_safe)
    end      
  end
end