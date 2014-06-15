# encoding: utf-8
require 'spec_helper'

describe 'NestedModelHelper' do
  
  include FormtasticSpecHelper

  before do
    @output_buffer = ''
    mock_everything   
  end
  
  describe '#nested_model' do
    it 'yields an instance of Formtastic::FormBuilder' do
      concat(semantic_form_for(@alan) do |builder|
        concat(builder.semantic_fields_for(:posts, :display_type => "table") do |post_builder|
          concat(post_builder.inputs do
            concat(post_builder.input :title)
            concat(post_builder.input :body)
          end)
        end)
      end)
      puts output_buffer
      output_buffer.should have_tag('form table.table-inputs', :count => 1)      
    end
  end
end