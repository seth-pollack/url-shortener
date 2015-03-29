require 'rails_helper'

RSpec.describe Url, type: :model do

	before :all do 
		@invaid_url = Url.create(link: 'www.example.com')
		@missing_link = Url.create
		@first, @second, @third = Url.create(link: 'http://one.com'),
			Url.create(link: 'http://two.com'), Url.create(link: 'http://three.com')
		@third.visits << Visit.create
	end

	context 'when url is missing http or https' do
		it 'should be invalid' do
			expect(@invaid_url).to_not be_valid
		end
	end

	context 'when url is missing link property' do
		it 'should be invalid' do
			expect(@missing_link).to_not be_valid
		end
	end

	context 'when link is in proper format' do
		it 'should be valid' do 
			expect(@first).to be_valid
		end
	end

	context 'when urls are queried' do
		it 'should order by visit count' do
			expect(Url.all).to eq([@third, @first, @second])
		end
	end

	describe '#find by slug' do
		it 'should query urls by slug' do
			expect(Url.find_by_slug('b')).to eq(@first)
		end
	end
	
	describe '#slug' do
		it 'should encode id and return a slug' do
			expect(@first.slug).to eq('b')
		end
	end
end
