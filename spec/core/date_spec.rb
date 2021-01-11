# frozen_string_literal: true

RSpec.describe Date do
  describe '#parse' do
    it 'prioritizes american formats' do
      expect(Date.parse '5/4/2001').to eq Date.new(2001, 5, 4)
    end
  end
end
