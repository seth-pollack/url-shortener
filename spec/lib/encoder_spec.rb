require 'rails_helper'

describe Encoder do

	describe '#encode' do
		it 'should encode a number' do
			expect(Encoder.encode(0)).to eq('a')
			expect(Encoder.encode(61)).to eq('9')
			expect(Encoder.encode(62)).to eq('ba')
			expect(Encoder.encode(124)).to eq('ca')
			expect(Encoder.encode(3844)).to eq('baa')
			expect(Encoder.encode(226981)).to eq('7c9')
			expect(Encoder.encode(238328)).to eq('baaa')
		end

		it 'should require positive numbers' do
			expect{Encoder.encode(-1)}.to raise_error(ArgumentError, /number cannot be negative/)
		end
	end
	describe '#decode' do
		it 'should encode a string' do
			expect(Encoder.decode('a')).to eq(0)
			expect(Encoder.decode('9')).to eq(61)
			expect(Encoder.decode('ba')).to eq(62)
			expect(Encoder.decode('ca')).to eq(124)
			expect(Encoder.decode('baa')).to eq(3844)
			expect(Encoder.decode('7c9')).to eq(226981)
			expect(Encoder.decode('baaa')).to eq(238328)
		end
	end
end
