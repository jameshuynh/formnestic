# rubocop:disable MethodLength, AbcSize
module Formnestic
  module Inputs
    module Base
      module Wrapping
        def table_builder?
          builder.options[:display_type] == 'table' ||
            if builder.options[:parent_builder]
              builder
                .options[:parent_builder]
                .options[:display_type] == 'table'
            else
              false
            end
        end

        def parent_table_builder?
          if builder.options[:parent_builder]
            builder
              .options[:parent_builder]
              .options[:display_type] == 'table'
          else
            false
          end
        end

        def input_wrapping(&block)
          if table_builder?
            if [
              'Formtastic::Inputs::DateSelectInput',
              'Formtastic::Inputs::TimeSelectInput',
              'Formtastic::Inputs::DateTimeSelectInput',
              'Formtastic::Inputs::TimeInput',
              'Formtastic::Inputs::DateInput'
            ].index(self.class.to_s)
              table_date_select_input_wrapping(&block)
            else
              table_input_wrapping(&block)
            end
          else
            formtastic_input_wrapping(&block)
          end
        end

        def table_date_select_input_wrapping(&block)
          unless parent_table_builder?
            builder
              .options[:parent_builder]
              .add_table_header(
                attributized_method_name,
                self.class,
                label_text
              )
          end

          template.content_tag(
            :td,
            template.content_tag(
              :div, [
                template.capture(&block), error_html, hint_html
              ].join("\n").html_safe,
              class: 'table-date-select-container'
            ), wrapper_html_options
          )
        end

        def table_input_wrapping(&block)
          unless parent_table_builder?
            builder
              .options[:parent_builder]
              .add_table_header(
                attributized_method_name,
                self.class,
                label_text
              )
          end

          template.content_tag(
            :td,
            [
              template.capture(&block),
              error_html,
              hint_html
            ].join("\n").html_safe,
            wrapper_html_options
          )
        end
      end
    end
  end
end
# rubocop:enable MethodLength, AbcSize
