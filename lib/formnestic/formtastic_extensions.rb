# rubocop:disable MethodLength, Documentation
module Formnestic
  module FormtasticExtensions
    def extend_form_builder
      Formtastic::FormBuilder.send(
        :alias_method,
        :formtastic_semantic_fields_for,
        :semantic_fields_for
      )
      Formtastic::FormBuilder.send(:include, Formnestic::FormBuilder)
      Formtastic::FormBuilder.class_eval do
        def semantic_fields_for(record_or_name_or_array, *args, &block)
          options = args.dup.extract_options!
          if options[:display_type] == 'table'
            formnestic_table_semantic_fields_for(
              record_or_name_or_array,
              *args,
              &block
            )
          elsif options[:row_removable].present? ||
                options[:row_addable].present?
            formnestic_list_semantic_fields_for(
              record_or_name_or_array,
              *args,
              &block
            )
          else
            formtastic_semantic_fields_for(
              record_or_name_or_array,
              *args,
              &block
            )
          end
        end
      end
    end

    def extend_form_inputs
      Formtastic::Inputs::Base.send(
        :alias_method,
        :formtastic_input_wrapping,
        :input_wrapping
      )
      Formtastic::Inputs::Base.send(
        :alias_method,
        :formtastic_render_label?,
        :render_label?
      )
      Formtastic::Inputs::Base.send(
        :include, Formnestic::Inputs::Base::Wrapping
      )
      Formtastic::Inputs::Base.send(
        :include, Formnestic::Inputs::Base::Labelling
      )
      Formtastic::Inputs::BooleanInput.send(
        :alias_method,
        :formtastic_label_text_with_embedded_checkbox,
        :label_text_with_embedded_checkbox
      )
    end

    def extend_datetime_related_inputs
      [
        'Formtastic::Inputs::DateSelectInput',
        'Formtastic::Inputs::DatetimeSelectInput',
        'Formtastic::Inputs::TimeSelectInput'
      ].each do |date_related_subclass_str|
        next unless defined?(date_related_subclass_str)
        date_related_subclass = date_related_subclass_str.constantize
        date_related_subclass.send(
          :alias_method,
          :formtastic_fragment_label_html,
          :fragment_label_html
        )
        date_related_subclass.class_eval do
          def fragment_label_html(fragment)
            if builder.options[:display_type] == 'table'
              ''.html_safe
            else
              formtastic_fragment_label_html(fragment)
            end
          end
        end
      end
    end

    def extend_boolean_input
      Formtastic::Inputs::BooleanInput.class_eval do
        def label_text_with_embedded_checkbox
          if builder.options[:display_type] == 'table'
            check_box_html
          else
            formtastic_label_text_with_embedded_checkbox
          end
        end
      end
    end
  end
end
