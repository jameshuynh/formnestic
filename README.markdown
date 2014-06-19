# formnestic

[![Build Status](https://travis-ci.org/jameshuynh/formnestic.svg?branch=master)](https://travis-ci.org/jameshuynh/formnestic)
[![Code Climate](https://codeclimate.com/github/jameshuynh/formnestic.png)](https://codeclimate.com/github/jameshuynh/formnestic)

An extension of famous [Formtastic form builder ](https://github.com/justinfrench/formtastic) to make building nested and association form extremely simple

### Compatibility

- Rails > 4.0 (Support will be soon available)
- Rails > 3.2
  - [Sample project for Rails 3.2](https://github.com/jameshuynh/formnestic-sample-rails3)

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

- Table form with row addable and removable
- List form with entry addable and removable

### Usage

#### List Form with entry addable and removable

Assuming we have the following models:

``rb
class QuizPool < ActiveRecord::Base
  attr_accessible :description, :title, :quiz_pool_questions_attributes
  
  has_many :quiz_pool_questions  
  accepts_nested_attributes_for :quiz_pool_questions
end

class QuizPoolQuestion < ActiveRecord::Base
  attr_accessible :description, :quiz_pool_id, :score, :quiz_pool_question_options_attributes
  
  validates :description, presence: true
  has_many :quiz_pool_question_options
  accepts_nested_attributes_for :quiz_pool_question_options
end
``

Then now we can write the following view to show a form contains ``quiz_pool`` attributes and nested form of ``quiz_pool_questions`` with the ability to add/remove questions.

- Notes:
  - ``row_removable``: Allow nested model entry to be removed.
  - ``row_addable``: Allow nested model entry to be added.
  - ``min_entry``: Minimum number of nested model entries that is allowed. An alert will be shown if user tries to delete the last entry that meets this minumum number.
  - ``max_entry``: Maximum number of nested model entries that is allowed. Add button will be hidden if user has already added enough entries.
  - ``new_record_link_label``: The label to be displayed in the Add button.

The following code:

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

will yield:

<p align="left" >
  <img src="https://raw.githubusercontent.com/jameshuynh/formnestic/master/screenshots/list_form.png" alt="List Form" title="List Form">
</p>

#### Table Form with entry row addable and removable

Assuming now we have the following ``quiz_pool_question_option`` model:

``rb
class QuizPoolQuestionOption < ActiveRecord::Base
  attr_accessible :description, :is_correct, :quiz_pool_question_id
  validates :description, presence: true  
end
``

Then now we can write the following view to show a table form contains ``quiz_pool_question`` attributes and nested form of ``quiz_pool_question_option`` with the ability to add/remove ``quiz_pool_question_option``.

- Notes:
  - ``display_type``: You will need to give string ``table`` here
  - ``row_removable``: Allow nested model entry to be removed.
  - ``row_addable``: Allow nested model entry to be added.
  - ``min_entry``: Minimum number of nested model entries that is allowed. An alert will be shown if user tries to delete the last entry that meets this minumum number.
  - ``max_entry``: Maximum number of nested model entries that is allowed. Add button will be hidden if user has already added enough entries.
  - ``new_record_link_label``: The label to be displayed in the Add button.

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
```

will yield the following table form for ``quiz_pool_question_option``

<p align="left" >
  <img src="https://raw.githubusercontent.com/jameshuynh/formnestic/master/screenshots/table_form.png" alt="Table Form" title="Table Form">
</p>

The controller code is pretty standard:

```rb
class QuizPoolsController < ApplicationController
  def new
    @quiz_pool = QuizPool.new
  end
  
  def create
    @quiz_pool = QuizPool.new(params[:quiz_pool])
    if @quiz_pool.save
      redirect_to :action => :show
    else
      render :action => :new      
    end
  end
  
  def show
    # show quiz pool here
    render :text => "TODO"
  end
  
end
```

And this is all you need to have to build a quiz engine. As you can see, the view code has __less than 40 lines of code__.

### Roadmap to version 2.0

- Sortable between nested model entry (including rows in a table)
- Delegator for alert view
- Ability to lock an entry

## Contributing to formnestic
 
- Contribution, Suggestion and Issues are very much appreciated :). Please also fork and send your pull request!
- Make sure to add tests for it when sending for pull requests. This is important so I don't break it in a future version unintentionally.

## Copyright

Copyright (c) 2014 James, released under the MIT license

