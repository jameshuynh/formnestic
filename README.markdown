# formnestic

[![Build Status](https://travis-ci.org/jameshuynh/formnestic.svg?branch=master)](https://travis-ci.org/jameshuynh/formnestic)
[![Code Climate](https://codeclimate.com/github/jameshuynh/formnestic.png)](https://codeclimate.com/github/jameshuynh/formnestic)

An extension of famous [Formtastic Form Builder](https://github.com/justinfrench/formtastic) to make building nested and association form with nested model addable and removable ability extremely easy and simple.

### Compatibility

- Formnestic gem requires ``formtastic`` gem version ``2.2.1``
- Formnestic gem is Rails 3 and Rails 4 compatible

### Installation

Add Formnestic to your Gemfile and run ``bundle install``:

```ruby
gem "formnestic", '~> 1.0.1'
```

then run the installation

```bash
bundle exec rails g formnestic:install
```

### Features

- Table form with row addable and removable
- List form with entry addable and removable

### Usage

Usage for rails 3 and rails 4 are almost the same, the only difference is that in Rails 4, you will need to remove all the ``attr_accessible`` in Rails 3 and use strong parameters in rails controller.

Basically, you can now add the following options into ``semantic_fields_for`` call in Formtastic

- ``display_type``: If you want your nested form to have table style, you can supply in ``table`` string
- ``row_removable``: Allow nested model entry to be removed.
- ``row_addable``: Allow nested model entry to be added.
- ``min_entry``: Minimum number of nested model entries that is allowed. An alert will be shown if user tries to delete the last entry that meets this minumum number.
- ``max_entry``: Maximum number of nested model entries that is allowed. Add button will be hidden if user has already added enough entries.
- ``new_record_link_label``: The label to be displayed in the Add button.
- ``table_headers``: A two(2) dimensional arrays, in which each array is presenting a row in table header row. For instance:

```rb
[
  [{label: 'Column 1', wrapper_html: {class: "big-column"}}, {label: 'Column 2'}],
  [{attr: :name}, {attr: :description}],
]
```

will yield a table header with 2 rows. The first row has 2 columns labeled ``Column 1`` and ``Column 2`` respectively, the second row labelled respected attribute's name of the nested model.

The form view is the same between Rails 3 and Rails 4

```erb
<%= semantic_form_for @quiz_pool do |quiz_pool_form| %>
  <%= quiz_pool_form.inputs do %>
    <%= quiz_pool_form.input :title %>
    <%= quiz_pool_form.input :description %>
    <li>
      <%= quiz_pool_form.semantic_fields_for :quiz_pool_questions, {
        row_removable: true, 
        row_addable: true,
        min_entry: 1, 
        max_entry: 5,
        new_record_link_label: "+ question"
      } do |quiz_pool_question_builder| %>
        <%= quiz_pool_question_builder.inputs do %>
          <%= quiz_pool_question_builder.input :description %>
          <%= quiz_pool_question_builder.input :score %>
        <% end %>
      <% end %>
    </li>
  <% end %>
  <%= quiz_pool_form.submit %>
<% end %>
```

See the usage for each of Rails version below for more details

#### Rails 3 Usage

- [Usage & Guideline](https://github.com/jameshuynh/formnestic/wiki/Rails-3-Guideline-and-Usage)
- [Sample project for Rails 3.2.18](https://github.com/jameshuynh/formnestic-sample-rails3)

#### Rails 4 Usage

- [Usage & Guideline](https://github.com/jameshuynh/formnestic/wiki/Rails-4-Guideline-and-Usage)
- [Sample project for Rails 4.1.1](https://github.com/jameshuynh/formnestic-sample-rails4)


#### Screenshots

##### Table Form

<p align="left" >
  <img src="https://raw.githubusercontent.com/jameshuynh/formnestic/master/screenshots/table_form.png" alt="Table Form" title="Table Form">
</p>

#### List Form

<p align="left" >
  <img src="https://raw.githubusercontent.com/jameshuynh/formnestic/master/screenshots/list_form.png" alt="List Form" title="List Form">
</p>

### Roadmap to version 2.0

- Sortable between nested model entry (including rows in a table)
- Delegator for alert view
- Ability to lock an entry

## Contributing to formnestic
 
- Contribution, Suggestion and Issues are very much appreciated :). Please also fork and send your pull request!
- Make sure to add tests for it when sending for pull requests. This is important so I don't break it in a future version unintentionally.

## Credits

- Big thanks to [Justin French](https://github.com/justinfrench) for bringing [Formtastic](https://github.com/justinfrench/formtastic) to our lives. It has enabled us to effectively code form much easier in rails and has enabled this gem to happen.

## Copyright

Copyright (c) 2014 James, released under the MIT license

