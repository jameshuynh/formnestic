module Formnestic
  module Helpers
    module InputsHelper
      def inputs(*args, &block)
        if options[:display_type] == 'table'  
          self.table_row_inputs(*args, &block)  
        elsif options[:row_removable] == true or options[:row_addable] == true
          self.list_row_inputs(*args, &block)
        else
          formtastic_inputs(*args, &block)
        end    
      end
      
      # for listing form
      def list_row_inputs(*args, &block)
        title = field_set_title_from_args(*args)
        self.options[:parent_builder].increase_rows_counter
        html_options = args.extract_options!
        html_options[:class] ||= "inputs"
        html_options[:name] = title
        
        html_options[:class] = html_options[:class].blank? ? "formnestic-li-fieldset" : "#{html_options[:class]} formnestic-li-fieldset"
        html_options[:class] = "#{html_options[:class]} #{self.options[:parent_builder].rows_counter % 2 == 0 ? 'formnestic-even-row': 'formnestic-odd-row'}"
        
        if options[:row_removable] == true
          contents = []
          contents.push(self.hidden_field(:_destroy, class: "formnestic-destroy-input", value: false))
          contents.push(template.content_tag(:div, '', title: I18n.t("formnestic.labels.remove_this_entry"), class: "formnestic-list-item-minus-button icon-cancel-circled", onclick: 'Formnestic.removeAListEntry(this);'))            
          row_removing_div = template.content_tag(:div, contents.join.html_safe, class: "formnestic-minus-button-container")
        else
          row_removing_div = ""
        end
        
        record_name = self.object.class.to_s.underscore.gsub("_", " ").singularize.downcase
        entity_name = I18n.t("activerecord.models.#{self.object.class.to_s.underscore.downcase}", default: record_name)
        
        content_div_content = template.content_tag(:span, record_name.titleize, class: "formnestic-li-fieldset-for") + "&nbsp;#".html_safe +  template.content_tag(:span, self.options[:parent_builder].rows_counter, class: "formnestic-li-fieldset-for-order")
        title_div = template.content_tag(:div, content_div_content, class: "formnestic-li-fieldset-legend")        
        template.content_tag(:fieldset, title_div + row_removing_div + template.capture(&block), html_options)
      end
      
      # For table form
      def table_row_inputs(*args, &block)
        wrap_it = @already_in_an_inputs_block ? true : false
        @already_in_an_inputs_block = true
      
        title = field_set_title_from_args(*args)
        html_options = args.extract_options!
        html_options[:class] ||= "inputs"
        html_options[:name] = title
        
        html_options[:class] = html_options[:class].blank? ? "formnestic-tr-fieldset" : "#{html_options[:class]} formnestic-tr-fieldset"
        html_options[:class] = "#{html_options[:class]} #{self.options[:parent_builder].rows_counter % 2 == 0 ? 'formnestic-even-row': 'formnestic-odd-row'}"
        
        self.options[:parent_builder].increase_rows_counter
        if options[:row_removable] == true
          contents = []
          contents.push(self.hidden_field(:_destroy, class: "formnestic-destroy-input", value: false))
          contents.push(template.content_tag(:div, '', title: I18n.t("formnestic.labels.remove_this_entry"), class: "formnestic-table-minus-button icon-cancel-circled", onclick: 'Formnestic.removeATableEntry(this);'))            
          row_removing_cell = template.content_tag(:td, contents.join.html_safe, class: "formnestic-minus-button-cell")
        else
          row_removing_cell = ""
        end
      
        template.content_tag(:tr, template.capture(&block) + row_removing_cell, html_options)
      end
    end
  end
end