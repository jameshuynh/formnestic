# formnestic

[![Build Status](https://travis-ci.org/jameshuynh/formnestic.svg?branch=master)](https://travis-ci.org/jameshuynh/formnestic)
[![Code Climate](https://codeclimate.com/github/jameshuynh/formnestic.png)](https://codeclimate.com/github/jameshuynh/formnestic)

An extension of [formtastic form builder](https://github.com/justinfrench/formtastic) gem to aids in building nested or association form

### Compatibility

- Rails > 4.0 (Support will be soon available)
- Rails > 3.2

### Installation

Add Formnestic to your Gemfile and run ``bundle install``:

```ruby
gem "formnestic"
```

### Usage

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
                  <%= quiz_pool_option_builder.input :description, as: :string, :hint => "abc" %>
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

## Contributing to formnestic
 
- Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
- Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
- Fork the project.
- Start a feature/bugfix branch.
- Commit and push until you are happy with your contribution.
- Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
- Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2014 James, released under the MIT license

