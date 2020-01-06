require 'rails_helper'

RSpec.describe List, type: :model do
  let(:valid_attributes) {
    {name: 'List 01', country: 'PK', city: 'Lahore', information_file: fixture_file_upload('files/vendors.xlsx', 'file')} 
  }

  context 'validation tests' do
    it 'ensure name presence' do
      list = List.new(name: '').save
      expect(list).to eq(false)
    end

    it 'ensure country presence' do
      list = List.new(country: '').save
      expect(list).to eq(false)
    end


    it 'ensure city presence' do
      list = List.new(city: '').save
      expect(list).to eq(false)
    end

    it 'ensure information_file presence' do
      list = List.new(information_file: nil).save
      expect(list).to eq(false)
    end

    it 'should save successfully' do
      list = List.new(valid_attributes).save
      expect(list).to eq(true)
    end
  end

end
