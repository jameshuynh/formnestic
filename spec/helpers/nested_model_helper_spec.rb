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
    
    it 'yields 4 table cells inside table.table-inputs' do
      output_buffer.should have_tag('form table.table-inputs tr td', :count => 6)
    end
    
    it 'must not yield any labels tag inside the table td' do
      output_buffer.should have_tag('form table.table-inputs tr td label', :count => 0)
    end
    
    it 'must have a table thead tag with 2 cells' do
      output_buffer.should have_tag('form table.table-inputs thead tr th.formnestic-minus-thead', count: 1)
      output_buffer.should have_tag('form table.table-inputs thead tr th', :count => 3)
    end
    
  end
end