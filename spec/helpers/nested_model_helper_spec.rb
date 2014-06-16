# encoding: utf-8
require 'spec_helper'

describe 'NestedModelHelper' do
  
  include FormtasticSpecHelper

  before do
    @output_buffer = ''
    mock_everything   
    
    concat(semantic_form_for(@alan) do |builder|
      concat(builder.semantic_fields_for(:posts, :display_type => "table", row_removable: true, row_addable: true) do |post_builder|
        concat(post_builder.inputs do
          concat(post_builder.input :title)
          concat(post_builder.input :body)
        end)
      end)
    end)    
  end
  
  describe '#nested_model' do
    it 'yields a table with class table-inputs' do
      output_buffer.should have_tag('form table.table-inputs', :count => 1)      
    end
    
    it 'yields 2 table rows with class tr-fieldset inside table.table-inputs' do
      output_buffer.should have_tag('form table.table-inputs tr.tr-fieldset', :count => 2)
    end
    
    it 'yields 7 table cells inside table.table-inputs' do
      output_buffer.should have_tag('form table.table-inputs tr td', :count => 7)
    end
    
    it 'yields 1 table cell containing a.formnestic-add-row-field-link' do
      output_buffer.should have_tag('form table.table-inputs tr td a.formnestic-add-row-field-link', :count => 1)
    end
    
    it 'must not yield any labels tag inside the table td' do
      output_buffer.should have_tag('form table.table-inputs tr td label', :count => 0)
    end
    
    it 'must have a table thead tag with 2 cells' do
      output_buffer.should have_tag('form table.table-inputs thead tr th.formnestic-minus-thead', count: 1)
      output_buffer.should have_tag('form table.table-inputs thead tr th', :count => 3)
    end
    
    it 'must have an a tag with onclick is addNewTableEntry javascript call' do
      output_buffer.should have_tag("form table.table-inputs tr.formnestic-table-no-border a", with: {'onclick' => %Q{Formnestic.addNewTableEntry(this, "posts", "&lt;tr class=\"inputs tr-fieldset\"&gt;&lt;td class=\"string input required stringish\" id=\"author_posts_attributes_new_posts_title_input\"&gt;&lt;input id=\"author_posts_attributes_new_posts_title\" name=\"author[posts_attributes][new_posts][title]\" type=\"text\" value=\"sample title\" /&gt;\n\n&lt;\/td&gt;&lt;td class=\"string input required stringish\" id=\"author_posts_attributes_new_posts_body_input\"&gt;&lt;input id=\"author_posts_attributes_new_posts_body\" name=\"author[posts_attributes][new_posts][body]\" type=\"text\" value=\"sample body\" /&gt;\n\n&lt;\/td&gt;&lt;td class=\"minus-button-cell\"&gt;&lt;input class=\"destroy-input\" id=\"author_posts_attributes_new_posts__destroy\" name=\"author[posts_attributes][new_posts][_destroy]\" type=\"hidden\" value=\"false\" /&gt;&lt;div class=\"formnestic-table-minus-button\" title=\"Remove this entry\"&gt;&lt;\/div&gt;&lt;\/td&gt;&lt;\/tr&gt;"); return false;}})
    end
    
  end
end