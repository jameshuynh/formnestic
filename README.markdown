# formnestic

[![Build Status](https://travis-ci.org/jameshuynh/formnestic.svg?branch=master)](https://travis-ci.org/jameshuynh/formnestic)
[![Code Climate](https://codeclimate.com/github/jameshuynh/formnestic.png)](https://codeclimate.com/github/jameshuynh/formnestic)

An extension of famous [Formtastic form builder ](https://github.com/justinfrench/formtastic) to make building nested and association form extremely simple

### Compatibility

- Rails > 4.0 (Support will be soon available)
- Rails > 3.2

### Installation

Add Formnestic to your Gemfile and run ``bundle install``:

```ruby
gem "formnestic"
```

then run the installation

```bash
bundle exec rails g formnestic:install
```

### Features

- Table form with row addable or removable
- List form with entry addable or removable

### Usage

Formnestic can be used to build a backend quiz engine in just __less than 40 lines of code__

```erb
<div style='width: 550px; margin: 20px auto; '>
  <div class='form-title'>New Quiz Pool</div>
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
            <li>
              <%= quiz_pool_question_builder.semantic_fields_for :quiz_pool_question_options, {
                display_type: "table", 
                row_removable: true, 
                row_addable: true, 
                min_entry: 1, 
                max_entry: 5,
                new_record_link_label: "+ answer"                
              } do |quiz_pool_option_builder| %>
                <%= quiz_pool_option_builder.inputs do %>
                  <%= quiz_pool_option_builder.input :description, as: :string, :hint => "e.g. Orange" %>
                  <%= quiz_pool_option_builder.input :is_correct %>
                <% end %>
              <% end %>
            </li>
          <% end %>
        <% end %>
      </li>
    <% end %>
    <%= quiz_pool_form.submit %>
  <% end %>
</div>
```

### Roadmap to version 2.0

- Sortable between nested model entry (including rows in a table)
- Delegator for alert view
- Ability to lock an entry

## Contributing to formnestic
 
- Contribution, Suggestion and Issues are very much appreciated :). Please also fork and send your pull request!
- Make sure to add tests for it when sending for pull requests. This is important so I don't break it in a future version unintentionally.

## Copyright

Copyright (c) 2014 James, released under the MIT license

