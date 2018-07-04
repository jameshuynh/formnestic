# rubocop:disable MethodLength, Documentation, ModuleLength, AbcSize
module Formnestic
  module FormBuilder
    module TableFormBuilder
      include Formnestic::FormBuilder::BaseBuilder
      def formnestic_table_semantic_fields_for(
        record_or_name_or_array, *args, &block
      )
        options = args.dup.extract_options!
        formnestic_add_table_headers_form_attributes
        formnestic_add_rows_counter_related_attributes

        child_form_builder = nil
        contents = [formtastic_semantic_fields_for(
          record_or_name_or_array,
          *args,
          &lambda { |nested_form_builder|
            child_form_builder = nested_form_builder
            yield(nested_form_builder)
          }
        )]

        if options[:row_addable]
          contents.push(
            formnestic_add_new_record_button_row_for_table(
              record_or_name_or_array, *args, &block
            )
          )
        end
        options[:class] = [
          'formnestic-table-inputs formnestic-nested-model',
          options[:class]
        ].compact.join(' ')
        options[:min_entry] ||= -1
        options[:max_entry] ||= -1
        options[:min_entry_alert_message] =
          formnestic_min_entry_alert_message(
            record_or_name_or_array, options[:min_entry]
          )

        ### Finally, wrap everything inside a table tag
        template.content_tag(:table, [
          formnestic_table_header(
            options,
            record_or_name_or_array,
            child_form_builder
          ), # table header
          template.content_tag(
            :tbody,
            Formtastic::Util.html_safe(contents.join)
          ) # table body
        ].join.html_safe, options.except(
                            :builder,
                            :parent,
                            :name,
                            :parent_builder,
                            :display_type,
                            :row_removable,
                            :new_record_link_label,
                            :table_headers
        ))
      end

      def formnestic_add_table_headers_form_attributes
        instance_eval do
          instance_variable_set('@table_headers', [])
          def table_headers
            @table_headers
          end

          def add_table_header(column_name, class_name, label_text)
            return if @table_headers.detect do |x|
              x[:attr] == column_name
            end.present?
            @table_headers.push(
              attr: column_name,
              class:
                class_name
                  .to_s
                  .tableize
                  .gsub('formtastic/inputs/', '')
                  .tr('_', '-')
                  .gsub('-inputs', ''),
              label_text: label_text
            )
          end
        end
      end

      def formnestic_add_new_record_button_row_for_table(
        record_or_name_or_array,
        *args,
        &block
      )
        template.content_tag(
          :tr,
          template.content_tag(
            :td,
            formnestic_link_to_add_fields_with_content(
              record_or_name_or_array, *args, &block
            ), colspan: '100%'
          ), class: 'formnestic-table-no-border'
        )
      end

      def formnestic_table_header(
        header_options, record_or_name_or_array, child_form_builder
      )
        thead_contents = if header_options[:table_headers]
                           formnestic_thead_contents_from_arguments(
                             header_options[:table_headers],
                             record_or_name_or_array, child_form_builder
                           )
                         else
                           formnestic_thead_contents_from_inputs(
                             header_options[:row_removable]
                           )
                         end
        template.content_tag(:thead, thead_contents.join.html_safe)
      end

      def formnestic_thead_contents_from_inputs(row_removable)
        tr_content_arr = []
        table_headers.each do |header|
          tr_content_arr.push(
            template.content_tag(
              :th,
              header[:label_text],
              class: header[:class]
            )
          )
        end
        if row_removable
          tr_content_arr.push(
            template.content_tag(
              :th, '', class: 'formnestic-minus-thead'
            )
          )
        end
        [template.content_tag(:tr, tr_content_arr.join.html_safe)]
      end

      def formnestic_thead_contents_from_arguments(
        theads,
        record_or_name_or_array,
        child_form_builder
      )
        thead_contents = []
        theads.each do |el_arr|
          tr_content_arr = []
          el_arr.each_with_index do |el, index|
            tr_content_arr
              .push(
                template.content_tag(
                  :th,
                  formnestic_table_thead_th_content(
                    record_or_name_or_array, el, index + 1, child_form_builder
                  ), el[:wrapper_html] || {}
                )
              )
          end
          thead_contents.push(
            template.content_tag(:tr, tr_content_arr.join.html_safe)
          )
        end
        thead_contents
      end

      def formnestic_table_thead_th_content(
        record_or_name_or_array,
        table_header_element_opts,
        position,
        child_form_builder
      )
        if table_header_element_opts[:attr].present?
          input_base =
            Formtastic::Inputs::StringInput.new(
              child_form_builder,
              '',
              record_or_name_or_array,
              child_form_builder.object,
              table_header_element_opts[:attr],
              {}
            )
          input_base.label_text
        elsif table_header_element_opts[:label].present?
          table_header_element_opts[:label].html_safe
        else
          "Column #{position}"
        end
      end
    end
  end
end
