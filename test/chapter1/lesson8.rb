require_relative '../../chapter1/lesson8'

RSpec.describe 'solution' do
  describe 'when n is 1' do
    it 'returns the correct sum' do
      expect(solution(1)).to eq(0.75)
    end
  end

  describe 'when n is 2' do
    it 'returns the correct sum' do
      expect(solution(2)).to eq(1.5833333333333335)
    end
  end

  describe 'when n is 3' do
    it 'returns the correct sum' do
      expect(solution(3)).to eq(2.4583333333333335)
    end
  end
end
