module Formnestic
  module Helpers
    module InputsHelper
      def inputs(*args, &block)
        if options[:display_type] == 'table'    
          wrap_it = @already_in_an_inputs_block ? true : false
          @already_in_an_inputs_block = true
        
          title = field_set_title_from_args(*args)
          html_options = args.extract_options!
          html_options[:class] ||= "inputs"
          html_options[:name] = title
          
          html_options[:class] = html_options[:class].blank? ? "formnestic-tr-fieldset" : "#{html_options[:class]} formnestic-tr-fieldset"
          if options[:row_removable] == true
            contents = []
            contents.push(self.hidden_field(:_destroy, class: "formnestic-destroy-input", value: false))
            contents.push(template.content_tag(:div, '', title: I18n.t("formnestic.labels.remove_this_entry"), class: "formnestic-table-minus-button icon-cancel-circled", onclick: 'Formnestic.removeATableEntry(this);'))            
            row_removing_cell = template.content_tag(:td, contents.join.html_safe, class: "formnestic-minus-button-cell")
          else
            row_removing_cell = ""
          end
        
          template.content_tag(:tr, template.capture(&block) + row_removing_cell, html_options)
        else
          formtastic_inputs(*args, &block)
        end    
      end            
    end
  end
end