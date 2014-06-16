module Formnestic
  module FormBuilder    
    def formnestic_table_semantic_fields_for(record_or_name_or_array, *args, &block)
      options = args.dup.extract_options!
      options[:parent_builder] ||= self 
      formnestic_add_table_headers_attributes
      
      existing_rows = formtastic_semantic_fields_for(record_or_name_or_array, *args, &block)
      new_object = self.object.class.reflect_on_association(record_or_name_or_array).klass.new
      min_entry = options[:min_entry] || -1
      
      contents = [existing_rows]
      if options[:row_addable]
        fields = formtastic_semantic_fields_for(record_or_name_or_array, new_object, :child_index => "new_#{record_or_name_or_array}", &block)        
        add_new_record_button_row = template.content_tag(:tr, template.content_tag(:td, template.link_to_add_fields_with_content(options[:new_record_link_label], self, record_or_name_or_array, fields, options), {colspan: "100%"}), class: "no-border")
        contents.add(add_new_record_button_row)
      end
          
      table_header = formnestic_table_header(options, record_or_name_or_array)
            
      options[:class] = options[:class].blank? ? "table-inputs nested-model" : "#{html_options[:class]} table-inputs nested-model"
      
      template.content_tag(:table,
        [table_header, template.content_tag(:tbody, Formtastic::Util.html_safe(contents.join))].join.html_safe,
        options.except(:builder, :parent, :name, :parent_builder, :display_type, :row_removable)
      )
    end
    
    def formnestic_add_table_headers_attributes
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