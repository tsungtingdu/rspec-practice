require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'Columns' do
    it 'has two columns' do
      columns = Course.column_names
      expect(columns).to include 'title'
      expect(columns).to include 'description'
    end
  end
end
