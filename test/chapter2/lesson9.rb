require_relative '../../chapter2/lesson9'

RSpec.describe 'solution' do
  describe "when n is 0" do
    it 'returns nil' do
      expect(solution(0)).to eq(nil)
    end
  end

  describe "when n is 10" do
    it 'returns result 4' do
      expect(solution(10)).to eq(4)
    end
  end

  describe "when n is 15" do
    it 'returns result 5' do
      expect(solution(15)).to eq(5)
    end
  end

  describe "when n is -5" do
    it 'returns nil' do
      expect(solution(-5)).to eq(nil)
    end
  end
end
