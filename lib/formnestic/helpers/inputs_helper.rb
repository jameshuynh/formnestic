module Formnestic
  module Helpers
    module InputsHelper
      def inputs(*args, &block)
        if options[:display_type] == 'table'  
          formnestic_table_row_inputs(*args, &block)  
        elsif options[:row_removable] or options[:row_addable]
          formnestic_list_row_inputs(*args, &block)
        else
          formtastic_inputs(*args, &block)
        end    
      end
      
      # for listing form
      def formnestic_list_row_inputs(*args, &block)
        html_options = args.extract_options!
        html_options[:name] = field_set_title_from_args(*args)
        html_options[:class] = [html_options[:class] || "inputs", "formnestic-li-fieldset", formnestic_row_class_based_on_position(options[:parent_builder].rows_counter)].join(" ")        
        self.options[:parent_builder].increase_rows_counter
                        
        rows_counter = template.content_tag(:span, self.options[:parent_builder].rows_counter, class: "formnestic-li-fieldset-for-order")
        content_div_content = [formnestic_legend_for_list_form, "&nbsp;#".html_safe, rows_counter].join
        title_div = template.content_tag(:div, content_div_content, class: "formnestic-li-fieldset-legend")        
        template.content_tag(:fieldset, title_div + (options[:row_removable] ? formnestic_row_removing_cell_for_list : '') + template.capture(&block), html_options)
      end
      
      # For table form
      def formnestic_table_row_inputs(*args, &block)
        html_options = args.extract_options!
        html_options[:name] = field_set_title_from_args(*args)
        html_options[:class] = [html_options[:class] || "inputs", "formnestic-tr-fieldset", formnestic_row_class_based_on_position(options[:parent_builder].rows_counter)].join(" ")
                
        self.options[:parent_builder].increase_rows_counter
        template.content_tag(:tr, template.capture(&block) + (options[:row_removable] ?
formnestic_row_removing_cell_for_table : ''), html_options)
      end
      
      def formnestic_row_class_based_on_position(position)
        position % 2 == 0 ? 'formnestic-even-row': 'formnestic-odd-row'
      end
      
      def formnestic_legend_for_list_form
        record_name = self.object.class.to_s.underscore.gsub("_", " ").singularize.downcase
        entity_name = I18n.t("activerecord.models.#{self.object.class.to_s.underscore.downcase}", default: record_name)
        template.content_tag(:span, record_name.titleize, class: "formnestic-li-fieldset-for")
      end
      
      def formnestic_row_removing_cell_for_list
        contents = []
        contents.push(self.hidden_field(:_destroy, class: "formnestic-destroy-input", value: false))
        contents.push(template.content_tag(:div, '', title: I18n.t("formnestic.labels.remove_this_entry"), class: "formnestic-list-item-minus-button icon-cancel-circled", onclick: 'Formnestic.removeAListEntry(this);'))
        template.content_tag(:div, contents.join.html_safe, class: "formnestic-minus-button-container")
      end
      
      def formnestic_row_removing_cell_for_table
        contents = []
        contents.push(self.hidden_field(:_destroy, class: "formnestic-destroy-input", value: false))
        contents.push(template.content_tag(:div, '', title: I18n.t("formnestic.labels.remove_this_entry"), class: "formnestic-table-minus-button icon-cancel-circled", onclick: 'Formnestic.removeATableEntry(this);'))
        template.content_tag(:td, contents.join.html_safe, class: "formnestic-minus-button-cell")
      end
    end
  end
end