module Formnestic
  module FormBuilder    
    def formnestic_table_semantic_fields_for(record_or_name_or_array, *args, &block)
      options[:parent_builder] ||= self 
      existing_rows = formtastic_semantic_fields_for(record_or_name_or_array, *args, &block)
      new_object = self.object.class.reflect_on_association(record_or_name_or_array).klass.new
      min_entry = options[:min_entry] || -1
      fields = formtastic_semantic_fields_for(record_or_name_or_array, new_object, :child_index => "new_#{record_or_name_or_array}", &block)
      # add_new_record_button_row = template.content_tag(:tr, template.content_tag(:td, template.link_to_add_fields_with_content(options[:new_record_link_label], self, record_or_name_or_array, fields, options), {colspan: "100%"}), class: "no-border")
      contents = [existing_rows, options[:show_new_record_link_button] ? add_new_record_button_row : nil].compact.join.html_safe
      
      html_options = args.extract_options!
      table_header = formnestic_table_header(html_options)
            
      html_options[:class] = html_options[:class].blank? ? "table-inputs nested-model" : "#{html_options[:class]} table-inputs nested-model"
      
      template.content_tag(:table,
        ["", template.content_tag(:tbody, Formtastic::Util.html_safe(contents))].join.html_safe,
        html_options.except(:builder, :parent, :name, :parent_builder)
      )
      
    end
        
    def formnestic_table_header(html_options)        
      thead_contents = []
      tr_content_arr = []
      
      if html_options[:thead]
        args[0][:thead].each do |el_arr|
    		  tr_content_arr = []
    		  el_arr.each do |el|
            tr_content_arr.push(template.content_tag(:th, el[:attr].blank? == false ? ::I18n.t("activerecord.attributes.#{self.association_name.to_s.singularize}.#{el[:attr]}") : "", el[:html_options]))
    		  end
    		  thead_contents.push(template.content_tag(:tr, tr_content_arr.join.html_safe))
    		end
      else
        #         @headers.each do |header|
        #           tr_content_arr.push(template.content_tag(:th, ::I18n.t("activerecord.attributes.#{self.association_name.to_s.singularize}.#{header[:attr]}"), class: header[:class]))
        # end
        #         if @is_showing_row_delete_button
        #           tr_content_arr.push(template.content_tag(:th, "", class: "minus-thead"))
        #         end
        # thead_contents = [template.content_tag(:tr, tr_content_arr.join.html_safe)]
      end
      return template.content_tag(:thead, thead_contents.join.html_safe)
    end      
  end
end