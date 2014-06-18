# encoding: utf-8
require 'spec_helper'

describe 'Formnestic List Form' do
  
  include FormtasticSpecHelper
  
  describe 'table formnestic with row_removable=true and row_addable=true' do
    before do
      @output_buffer = ''
      mock_everything   
    
      concat(semantic_form_for(@alan) do |builder|
        concat(builder.semantic_fields_for(:posts, row_removable: true, row_addable: true) do |post_builder|
          concat(post_builder.inputs do
            concat(post_builder.input :title)
            concat(post_builder.input :body)
          end)
        end)
      end)
    end
    it 'must not yields any table with class table-inputs' do
      output_buffer.should_not have_tag('form table.formnestic-table-inputs')
    end
  
    it 'must have an a tag with onclick is addNewListingEntry javascript call' do
      output_buffer.should have_tag("form a[@onclick*='Formnestic.addNewListEntry']")
    end      
    
    it 'must have a div tag with class formnestic-list-new-entry-link-container' do
      output_buffer.should have_tag("form div.formnestic-list-new-entry-link-container")
    end    
    
    it 'should have 2 div tag with class formnestic-li-fieldset' do
      output_buffer.should have_tag("form fieldset.formnestic-li-fieldset", count: 2)
    end    
    
    it 'should have 2 span tag with class formnestic-li-fieldset-for' do
      output_buffer.should have_tag("form span.formnestic-li-fieldset-for", count: 2)
    end    
    
    it 'should have 2 span tag with class formnestic-li-fieldset-for' do
      output_buffer.should have_tag("form span.formnestic-li-fieldset-for-order", count: 2)
    end    
    
    it 'should have 2 div tag with class formnestic-table-minus-button' do
      output_buffer.should have_tag("form div.formnestic-list-item-minus-button", count: 2)
    end    
    
  end
end