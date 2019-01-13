# frozen_string_literal: true

require 'promotions/product_promotion'
require 'product'

RSpec.describe Promotions::ProductPromotion do
  subject { described_class.new(condition_fun: condition_fun, discount_fun: discount_fun) }

  let(:condition_fun) { ->(products) { products.any? { |product| product.code == '001' } } }
  let(:discount_fun) do
    ->(products) { products.select { |product| product.code == '001' }.map { |product| 0.05 * product.price }.sum }
  end

  let(:products) { [product1] }
  let(:product1) { Product.new(code: '001', name: 'Lavender heart', price: 11) }

  describe '#apply?' do
    context 'when the condition is `true`' do
      it 'returns `true`' do
        expect(subject.apply?(products)).to eq(true)
      end
    end

    context 'when the condition is `false`' do
      let(:condition_fun) { ->(products) { products.any? { |product| product.code == 'none' } } }

      it 'returns `false`' do
        expect(subject.apply?(products)).to eq(false)
      end
    end
  end

  describe '#discount' do
    it 'returns the calculated discount products' do
      expect(subject.discount(products)).to eq(0.55)
    end
  end
end
