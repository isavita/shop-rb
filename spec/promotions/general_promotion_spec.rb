# frozen_string_literal: true

require 'promotions/general_promotion'

RSpec.describe Promotions::GeneralPromotion do
  subject { described_class.new(condition_fun: condition_fun, discount_fun: discount_fun) }

  let(:condition_fun) { ->(amount) { amount > 50 } }
  let(:discount_fun) { ->(amount) { 0.25 * amount } }
  let(:amount) { 100 }

  describe '#apply?' do
    context 'when the condition is `true`' do
      it 'returns `true`' do
        expect(subject.apply?(amount)).to eq(true)
      end
    end

    context 'when the condition is `false`' do
      let(:amount) { 10 }

      it 'returns `false`' do
        expect(subject.apply?(amount)).to eq(false)
      end
    end
  end

  describe '#discount' do
    it 'returns the calculated discount amount' do
      expect(subject.discount(amount)).to eq(25)
    end
  end
end
