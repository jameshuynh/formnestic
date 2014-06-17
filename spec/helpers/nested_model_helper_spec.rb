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
          concat(post_builder.input :post_date, as: :date)
        end)
      end)
    end)
  end
  
  describe '#nested_model' do
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
    
    it 'must not have label tag inside a date cell' do
      output_buffer.should_not have_tag('form table.formnestic-table-inputs tbody td.date label')
    end
    
    it 'must have an a tag with onclick is addNewTableEntry javascript call' do
      output_buffer.should have_tag("form table.formnestic-table-inputs tr.formnestic-table-no-border a", with: {'onclick' => %Q{Formnestic.addNewTableEntry(this, "posts", "&lt;tr class=\"inputs tr-fieldset\"&gt;&lt;td class=\"string input required stringish\" id=\"author_posts_attributes_new_posts_title_input\"&gt;&lt;input id=\"author_posts_attributes_new_posts_title\" name=\"author[posts_attributes][new_posts][title]\" type=\"text\" value=\"sample title\" /&gt;\n\n&lt;\/td&gt;&lt;td class=\"string input required stringish\" id=\"author_posts_attributes_new_posts_body_input\"&gt;&lt;input id=\"author_posts_attributes_new_posts_body\" name=\"author[posts_attributes][new_posts][body]\" type=\"text\" value=\"sample body\" /&gt;\n\n&lt;\/td&gt;&lt;td class=\"date input required\" id=\"author_posts_attributes_new_posts_post_date_input\"&gt;&lt;div class=\"table-date-select-container\"&gt;&lt;fieldset class=\"fragments\"&gt;&lt;ol class=\"fragments-group\"&gt;&lt;li class=\"fragment\"&gt;&lt;select id=\"author_posts_attributes_new_posts_post_date_1i\" name=\"author[posts_attributes][new_posts][post_date(1i)]\"&gt;\n&lt;option value=\"\"&gt;&lt;\/option&gt;\n&lt;option value=\"2009\"&gt;2009&lt;\/option&gt;\n&lt;option value=\"2010\"&gt;2010&lt;\/option&gt;\n&lt;option value=\"2011\"&gt;2011&lt;\/option&gt;\n&lt;option value=\"2012\"&gt;2012&lt;\/option&gt;\n&lt;option value=\"2013\"&gt;2013&lt;\/option&gt;\n&lt;option selected=\"selected\" value=\"2014\"&gt;2014&lt;\/option&gt;\n&lt;option value=\"2015\"&gt;2015&lt;\/option&gt;\n&lt;option value=\"2016\"&gt;2016&lt;\/option&gt;\n&lt;option value=\"2017\"&gt;2017&lt;\/option&gt;\n&lt;option value=\"2018\"&gt;2018&lt;\/option&gt;\n&lt;option value=\"2019\"&gt;2019&lt;\/option&gt;\n&lt;\/select&gt;\n&lt;\/li&gt;&lt;li class=\"fragment\"&gt;&lt;select id=\"author_posts_attributes_new_posts_post_date_2i\" name=\"author[posts_attributes][new_posts][post_date(2i)]\"&gt;\n&lt;option value=\"\"&gt;&lt;\/option&gt;\n&lt;option value=\"1\"&gt;January&lt;\/option&gt;\n&lt;option value=\"2\"&gt;February&lt;\/option&gt;\n&lt;option value=\"3\"&gt;March&lt;\/option&gt;\n&lt;option value=\"4\"&gt;April&lt;\/option&gt;\n&lt;option value=\"5\"&gt;May&lt;\/option&gt;\n&lt;option selected=\"selected\" value=\"6\"&gt;June&lt;\/option&gt;\n&lt;option value=\"7\"&gt;July&lt;\/option&gt;\n&lt;option value=\"8\"&gt;August&lt;\/option&gt;\n&lt;option value=\"9\"&gt;September&lt;\/option&gt;\n&lt;option value=\"10\"&gt;October&lt;\/option&gt;\n&lt;option value=\"11\"&gt;November&lt;\/option&gt;\n&lt;option value=\"12\"&gt;December&lt;\/option&gt;\n&lt;\/select&gt;\n&lt;\/li&gt;&lt;li class=\"fragment\"&gt;&lt;select id=\"author_posts_attributes_new_posts_post_date_3i\" name=\"author[posts_attributes][new_posts][post_date(3i)]\"&gt;\n&lt;option value=\"\"&gt;&lt;\/option&gt;\n&lt;option value=\"1\"&gt;1&lt;\/option&gt;\n&lt;option value=\"2\"&gt;2&lt;\/option&gt;\n&lt;option value=\"3\"&gt;3&lt;\/option&gt;\n&lt;option value=\"4\"&gt;4&lt;\/option&gt;\n&lt;option value=\"5\"&gt;5&lt;\/option&gt;\n&lt;option value=\"6\"&gt;6&lt;\/option&gt;\n&lt;option value=\"7\"&gt;7&lt;\/option&gt;\n&lt;option value=\"8\"&gt;8&lt;\/option&gt;\n&lt;option value=\"9\"&gt;9&lt;\/option&gt;\n&lt;option value=\"10\"&gt;10&lt;\/option&gt;\n&lt;option value=\"11\"&gt;11&lt;\/option&gt;\n&lt;option value=\"12\"&gt;12&lt;\/option&gt;\n&lt;option value=\"13\"&gt;13&lt;\/option&gt;\n&lt;option value=\"14\"&gt;14&lt;\/option&gt;\n&lt;option value=\"15\"&gt;15&lt;\/option&gt;\n&lt;option value=\"16\"&gt;16&lt;\/option&gt;\n&lt;option selected=\"selected\" value=\"17\"&gt;17&lt;\/option&gt;\n&lt;option value=\"18\"&gt;18&lt;\/option&gt;\n&lt;option value=\"19\"&gt;19&lt;\/option&gt;\n&lt;option value=\"20\"&gt;20&lt;\/option&gt;\n&lt;option value=\"21\"&gt;21&lt;\/option&gt;\n&lt;option value=\"22\"&gt;22&lt;\/option&gt;\n&lt;option value=\"23\"&gt;23&lt;\/option&gt;\n&lt;option value=\"24\"&gt;24&lt;\/option&gt;\n&lt;option value=\"25\"&gt;25&lt;\/option&gt;\n&lt;option value=\"26\"&gt;26&lt;\/option&gt;\n&lt;option value=\"27\"&gt;27&lt;\/option&gt;\n&lt;option value=\"28\"&gt;28&lt;\/option&gt;\n&lt;option value=\"29\"&gt;29&lt;\/option&gt;\n&lt;option value=\"30\"&gt;30&lt;\/option&gt;\n&lt;option value=\"31\"&gt;31&lt;\/option&gt;\n&lt;\/select&gt;\n&lt;\/li&gt;&lt;\/ol&gt;&lt;\/fieldset&gt;\n\n&lt;\/div&gt;&lt;\/td&gt;&lt;td class=\"formnestic-minus-button-cell\"&gt;&lt;input class=\"formnestic-destroy-input\" id=\"author_posts_attributes_new_posts__destroy\" name=\"author[posts_attributes][new_posts][_destroy]\" type=\"hidden\" value=\"false\" /&gt;&lt;div class=\"formnestic-table-minus-button icon-cancel-circled\" title=\"Remove this entry\"&gt;&lt;\/div&gt;&lt;\/td&gt;&lt;\/tr&gt;"); return false;}})
    end
    
  end
end