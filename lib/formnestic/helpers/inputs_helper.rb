# rubocop:disable MethodLength, AbcSize, ModuleLength
module Formnestic
  module Helpers
    module InputsHelper
      def inputs(*args, &block)
        if options[:display_type] == 'table'
          formnestic_table_row_inputs(*args, &block)
        elsif options[:row_removable] || options[:row_addable]
          formnestic_list_row_inputs(*args, &block)
        else
          formtastic_inputs(*args, &block)
        end
      end

      # for listing form
      def formnestic_list_row_inputs(*args, &block)
        html_options =
          formnestic_prepare_html_options_for_wrapper(:list, *args)
        rows_counter =
          template.content_tag(
            :span,
            options[:parent_builder].rows_counter,
            class: 'formnestic-li-fieldset-for-order'
          )
        content_div_content = [
          formnestic_legend_for_list_form,
          '&nbsp;#'.html_safe,
          rows_counter
        ].join.html_safe
        title_div = template.content_tag(
          :div,
          content_div_content,
          class: 'formnestic-li-fieldset-legend'
        )
        template.content_tag(
          :fieldset, [
            title_div, (
              if options[:row_removable]
                formnestic_row_removing_content_tag(:list)
              else
                ''
              end
            ),
            template.capture(&block)
          ].join.html_safe,
          html_options
        )
      end

      # For table form
      def formnestic_table_row_inputs(*args, &block)
        html_options =
          formnestic_prepare_html_options_for_wrapper(:table, *args)
        template.content_tag(
          :tr, [
            template.capture(&block), (
              if options[:row_removable]
                formnestic_row_removing_content_tag(:table)
              else
                ''
              end
            )
          ].join.html_safe, html_options
        )
      end

      def formnestic_legend_for_list_form
        record_name = if options[:record_header].present?
                        options[:record_header]
                      else
                        object
                          .class
                          .to_s
                          .underscore
                          .tr('_', ' ')
                          .singularize
                          .downcase
                          .titleize
                      end
        template.content_tag(
          :span,
          record_name,
          class: 'formnestic-li-fieldset-for'
        )
      end

      def formnestic_row_removing_content_tag(form_type)
        contents = []
        contents.push(
          hidden_field(
            :_destroy,
            class: 'formnestic-destroy-input',
            value: object.marked_for_destruction?
          )
        )
        contents.push(
          template.content_tag(
            :div,
            '',
            title: I18n.t('formnestic.labels.remove_this_entry'),
            class: "#{formnestic_row_removing_cell_div_class(form_type)} \
icon-cancel-circled",
            onclick: formnestic_row_removing_cell_js_call(form_type)
          )
        )
        template.content_tag(
          form_type == :table ? :td : :div,
          contents.join.html_safe,
          class: formnestic_row_removing_cell_container_div_class(form_type)
        )
      end

      def formnestic_prepare_html_options_for_wrapper(form_type, *args)
        html_options = args.extract_options!
        html_options[:name] = field_set_title_from_args(*args)
        html_options[:class] = [
          html_options[:class] || 'inputs',
          formnestic_wrapper_class(form_type),
          formnestic_row_class_based_on_position(
            options[:parent_builder].rows_counter
          )
        ].join(' ')
        if object.marked_for_destruction?
          html_options[:style] = [
            html_options[:style],
            'display: none'
          ].compact.join(';')
        end
        options[:parent_builder].increase_rows_counter
        html_options
      end

      def formnestic_wrapper_class(form_type)
        if form_type == :table
          'formnestic-tr-fieldset'
        else
          'formnestic-li-fieldset'
        end
      end

      def formnestic_row_removing_cell_js_call(form_type)
        if form_type == :table
          'Formnestic.removeATableEntry(this);'
        else
          'Formnestic.removeAListEntry(this);'
        end
      end

      def formnestic_row_removing_cell_div_class(form_type)
        if form_type == :table
          'formnestic-table-minus-button'
        else
          'formnestic-list-item-minus-button'
        end
      end

      def formnestic_row_removing_cell_container_div_class(form_type)
        if form_type == :table
          'formnestic-minus-button-cell'
        else
          'formnestic-minus-button-container'
        end
      end

      def formnestic_row_class_based_on_position(position)
        position.even? ? 'formnestic-even-row' : 'formnestic-odd-row'
      end
    end
  end
end
# rubocop:enable all
