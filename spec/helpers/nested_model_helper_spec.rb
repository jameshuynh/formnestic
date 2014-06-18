# encoding: utf-8
require 'spec_helper'

describe 'Formnestic Table Form' do
  
  include FormtasticSpecHelper
  
  describe 'table formnestic with row_removable=true and row_addable=true' do
    before do
      @output_buffer = ''
      mock_everything   
    
      concat(semantic_form_for(@alan) do |builder|
        concat(builder.semantic_fields_for(:posts, :display_type => "table", row_removable: true, row_addable: true) do |post_builder|
          concat(post_builder.inputs do
            concat(post_builder.input :title)
            concat(post_builder.input :body)
            concat(post_builder.input :post_date, as: :date_select)
          end)
        end)
      end)
    end
    
    it 'yields a table with class table-inputs' do
      output_buffer.should have_tag('form table.formnestic-table-inputs', :count => 1)      
    end
    
    it 'yields 2 table rows with class formnestic-tr-fieldset inside table.formnestic-table-inputs' do
      output_buffer.should have_tag('form table.formnestic-table-inputs tr.formnestic-tr-fieldset', :count => 2)
    end
    
    it 'yields 7 table cells inside table.table-inputs' do
      output_buffer.should have_tag('form table.formnestic-table-inputs tr td', :count => 9)
    end
    
    it 'yields 1 table cell containing a.formnestic-add-row-field-link' do
      output_buffer.should have_tag('form table.formnestic-table-inputs tr td a.formnestic-add-row-field-link', :count => 1)
    end
    
    it 'must not yield any labels tag inside the table td' do
      output_buffer.should have_tag('form table.formnestic-table-inputs tr td label', :count => 0)
    end
    
    it 'must have a table thead tag with 2 cells' do
      output_buffer.should have_tag('form table.formnestic-table-inputs thead tr th.formnestic-minus-thead', count: 1)
      output_buffer.should have_tag('form table.formnestic-table-inputs thead tr th', :count => 4)
    end
    
    it 'must have a table thead tag with 2 cells' do
      output_buffer.should have_tag('form table.formnestic-table-inputs thead tr th.formnestic-minus-thead', count: 1)
      output_buffer.should have_tag('form table.formnestic-table-inputs thead tr th', :count => 4)
    end
    
    it 'must have 2 div.formnestic-table-minus-button' do
      output_buffer.should have_tag('form table.formnestic-table-inputs tbody div.formnestic-table-minus-button', count: 2)
    end
    
    it 'must not have label tag inside a date cell' do
      output_buffer.should_not have_tag('form table.formnestic-table-inputs tbody td.date label')
    end
    
    it 'must have a tag with onclick is addNewTableEntry javascript call' do
      output_buffer.should have_tag("form table.formnestic-table-inputs tr.formnestic-table-no-border a[@onclick*='Formnestic.addNewTableEntry']")
    end    
  end
  
  describe 'table formnestic with row_removable=false and row_addable=true' do
    before do
      @output_buffer = ''
      mock_everything   
    
      concat(semantic_form_for(@alan) do |builder|
        concat(builder.semantic_fields_for(:posts, :display_type => "table", row_removable: false, row_addable: true) do |post_builder|
          concat(post_builder.inputs do
            concat(post_builder.input :title)
            concat(post_builder.input :body)
            concat(post_builder.input :post_date, as: :date_select)
          end)
        end)
      end)
    end
    
    it 'must not have any div.formnestic-table-minus-button' do
      output_buffer.should have_tag('form table.formnestic-table-inputs tbody div.formnestic-table-minus-button', count: 0)
    end
  end
  
  describe 'table formnestic with row_removable=true and row_addable=false' do
    before do
      @output_buffer = ''
      mock_everything   
    
      concat(semantic_form_for(@alan) do |builder|
        concat(builder.semantic_fields_for(:posts, :display_type => "table", row_removable: true, row_addable: false) do |post_builder|
          concat(post_builder.inputs do
            concat(post_builder.input :title)
            concat(post_builder.input :body)
            concat(post_builder.input :post_date, as: :date_select)
          end)
        end)
      end)
    end
    
    it 'must not have an a tag with onclick is addNewTableEntry javascript call' do
      output_buffer.should have_tag("form table.formnestic-table-inputs tr.formnestic-table-no-border a[@onclick*='Formnestic.addNewTableEntry']", count: 0)
    end
  end
  
  describe 'table formnestic with custom new record link label' do
    before do
      @output_buffer = ''
      mock_everything   
    
      concat(semantic_form_for(@alan) do |builder|
        concat(builder.semantic_fields_for(:posts, :display_type => "table", row_removable: true, row_addable: true, new_record_link_label: "Add new option") do |post_builder|
          concat(post_builder.inputs do
            concat(post_builder.input :title)
            concat(post_builder.input :body)
            concat(post_builder.input :post_date, as: :date_select)
          end)
        end)
      end)
    end
    
    it "must have a tag with onclick is addNewTableEntry javascript call and text is Add new option" do
      output_buffer.should have_tag("form table.formnestic-table-inputs tr.formnestic-table-no-border a[@onclick*='Formnestic.addNewTableEntry']", "Add new option", count: 1)
    end
  end
  
  describe 'table formnestic with boolean field' do
    before do
      @output_buffer = ''
      mock_everything   
    
      concat(semantic_form_for(@alan) do |builder|
        concat(builder.semantic_fields_for(:posts, :display_type => "table", row_removable: true, row_addable: true, new_record_link_label: "Add new option") do |post_builder|
          concat(post_builder.inputs do
            concat(post_builder.input :recent, as: :boolean)
          end)
        end)
      end)
    end
    
    it "must not have is new text in boolean input" do
      output_buffer.should_not have_tag("form table.formnestic-table-inputs tbody label", "Recent")
    end
  end
end