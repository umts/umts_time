# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TimeModel do
  describe 'atomic time fields' do
    it 'casts them correctly' do
      model = TimeModel.new start_time: '9:00 am', end_time: '5:00 pm'

      expect(model.start_time).to eq AtomicTime.new 9
      expect(model.end_time).to eq AtomicTime.new 17

      model.save!

      expect(model.start_time).to eq AtomicTime.new 9
      expect(model.end_time).to eq AtomicTime.new 17
    end

    it 'adjusts interval values on save' do
      model = TimeModel.new start_time: '9:00 am', end_time: '5:00 am'
      model.save

      expect(model.end_time).to eq AtomicTime.new(24 + 5)
    end
  end
end
