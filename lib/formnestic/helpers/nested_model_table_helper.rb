module Formnestic
  module Helpers
    module NestedModelTableHelper
      def link_to_add_fields_with_content(name, f, association, content, opts={})
        link_to_add_fields_delegate(name, f, association, content, opts)
      end

      def link_to_add_fields_delegate(name, f, association, content, opts={})
        extra_class = opts[:max_entry] == -1 ? "" : (f.object.send(association).count >= opts[:max_entry].to_i ? "hidden" : "")
        min_entry = opts[:min_entry] || -1
        if f.class == RubifyDashboard::TableFormBuilder
          link_to_function(name, "RubifyJS.add_table_fields(this, \"#{association}\", \"#{escape_javascript(content)}\")", :class => "add-field-link #{extra_class}", "data-max-entry" => opts[:max_entry], "data-min-entry" => min_entry, "data-min-entry-alert" => min_entry != -1 ? opts[:min_entry_alert_message] || I18n.t('rubify_dashboard.there_must_be_at_least_entries', {count: (min_entry), entity_singular: I18n.t("activerecord.models.#{association.to_s.singularize}"), entity_plural: I18n.t("activerecord.models.#{association.to_s.singularize}").pluralize}) : '')
        else
          link_to_function(name, "RubifyJS.add_fields(this, \"#{association}\", \"#{escape_javascript(content)}\")", :class => "add-field-link #{extra_class}", "data-max-entry" => opts[:max_entry], "data-min-entry" => min_entry, "data-min-entry-alert" => min_entry != -1 ? opts[:min_entry_alert_message] || I18n.t('rubify_dashboard.there_must_be_at_least_entries', {count: (min_entry), entity_singular: I18n.t("activerecord.models.#{association.to_s.singularize}"), entity_plural: I18n.t("activerecord.models.#{association.to_s.singularize}").pluralize}) : '')
        end
      end

      def link_to_delete_entry(form, do_not_delete_last_entry=false, opts={})
        (form.hidden_field :_destroy, class: "destroy-input", value: false) + content_tag(:a, t("rubify_dashboard.web_actions.delete_entry"), {class: "remove normal-entry-delete #{do_not_delete_last_entry ? "at-least-one-entry" : ""}", style: "position: absolute; top: -4px; right: 0;", href:'#'}.merge(opts).merge(do_not_delete_last_entry ? {"data-one-entry-message" => ::I18n.t('rubify_dashboard.web_actions.at_least_one_entry_needs_to_be_here')} : {}))
      end
    end
  end
end