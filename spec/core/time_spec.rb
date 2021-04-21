# frozen_string_literal: true

RSpec.describe Time do
  describe '#parse' do
    it 'prioritizes american formats' do
      expect(Time.parse '5/4/2001 9:00 am').to eq Time.new(2001, 5, 4, 9)
    end
  end
end
