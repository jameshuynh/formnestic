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
          
          html_options[:class] = html_options[:class].blank? ? "tr-fieldset" : "#{html_options[:class]} tr-fieldset"
          contents = []
          contents.push(self.hidden_field(:_destroy, class: "destroy-input", value: false))
          contents.push(template.content_tag(:div, '', title: I18n.t("rubify_dashboard.web_actions.delete_entry"), class: "table-minus-button"))
          if options[:show_delete_button] == true
            delete_cell = template.content_tag(:td, contents.join.html_safe, class: "minus-button-cell")
          else
            delete_cell = ""
          end
        
          template.content_tag(:tr, template.capture(&block) + delete_cell, html_options)
        else
          formtastic_inputs(*args, &block)
        end    
      end            
    end
  end
end