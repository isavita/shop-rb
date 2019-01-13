# frozen_string_literal: true

require 'calculate_discount/action'
require 'product'
require 'promotions/product_promotion'

RSpec.describe CalculateDiscount::Action do
  subject { described_class.new(promotions: promotions, products: products).call }

  let(:promotions) { [] }
  let(:products) { [product1] }
  let(:product1) { Product.new(code: '001', name: 'Lavender heart', price: 9.25) }

  context 'without promotions' do
    it 'returns zero discount' do
      expect(subject).to eq(0)
    end
  end

  context 'with promotions' do
    let(:promotions) { [promotion1] }
    let(:promotion1) do
      Promotions::ProductPromotion.new(
        condition_fun: ->(products) { products.any? { |product| product.code == '001' } },
        discount_fun: lambda do |products|
          products.select { |product| product.code == '001' }.map { |product| 0.2 * product.price }.sum
        end
      )
    end

    it 'returns the promotion discount' do
      expect(subject).to eq(1.85)
    end
  end
end
