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

Usage for rails 3 and rails 4 are almost the same, the only difference is that in rails4, you will need to remove all the ``attr_accessible`` inr rails3 and use strong parameters in rails controller.

#### Rails 3 Usage

[Usage & Guideline](https://github.com/jameshuynh/formnestic/wiki/Rails-3-Guideline-and-Usage)

#### Rails 4 Usage

[Usage & Guideline](https://github.com/jameshuynh/formnestic/wiki/Rails-4-Guideline-and-Usage)

### Roadmap to version 2.0

- Sortable between nested model entry (including rows in a table)
- Delegator for alert view
- Ability to lock an entry

## Contributing to formnestic
 
- Contribution, Suggestion and Issues are very much appreciated :). Please also fork and send your pull request!
- Make sure to add tests for it when sending for pull requests. This is important so I don't break it in a future version unintentionally.

## Copyright

Copyright (c) 2014 James, released under the MIT license

