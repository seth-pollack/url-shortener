module Encoder
	LETTERS = ['a'..'z', 'A'..'Z', (0..9).collect { |i| i.to_s }].map(&:to_a).flatten.freeze
	BASE = LETTERS.count
	class << self
		def decode(string)
			string.chars.inject(0) { |sum, char| sum * BASE + LETTERS.index(char) }
		end

		def encode(number)
			raise ArgumentError, 'number cannot be negative' if number < 0
			i = number
			string = number == 0 ? LETTERS[number] : ''
			while i > 0
			    string << LETTERS[ i % BASE ]
			    i /= BASE
			end
			string.reverse
		end
	end
end
