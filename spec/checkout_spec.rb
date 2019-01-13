# frozen_string_literal: true

require 'checkout'
require 'product'
require 'promotions/general_promotion'

RSpec.describe Checkout do
  subject { described_class.new(promotions) }

  let(:promotions) { [] }
  let(:product1) { Product.new(code: '001', name: 'Lavender heart', price: 9.25) }

  describe '#scan' do
    it 'adds product to the products' do
      subject.scan(product1)

      expect(subject.products).to contain_exactly(product1)
    end
  end

  describe '#total' do
    let(:product2) { Product.new(code: '002', name: 'Personalised cufflinks', price: 45.0) }
    let(:product3) { Product.new(code: '003', name: 'Kids T-shirt', price: 19.95) }

    before do
      subject.scan(product1)
      subject.scan(product2)
      subject.scan(product3)
    end

    context 'without promotions' do
      it 'returns the full amount without any discount' do
        expect(subject.total).to eq(74.2)
      end
    end

    context 'with general promotions' do
      let(:promotions) { [general_promotion] }
      let(:general_promotion) do
        Promotions::GeneralPromotion.new(
          condition_fun: ->(amount) { amount > 60.0 },
          discount_fun: ->(amount) { 0.1 * amount }
        )
      end

      it 'return the amount with deduced discount' do
        expect(subject.total).to eq(66.78)
      end

      context 'with product promotions' do
        let(:promotions) { [general_promotion, product_promotion] }
        let(:product_promotion) do
          Promotions::ProductPromotion.new(
            condition_fun: ->(products) { products.select { |product| product.code == '001' }.count > 1 },
            discount_fun: ->(products) { products.select { |product| product.code == '001' }.map { |_| 0.75 }.sum }
          )
        end

        before { subject.scan(product1) }

        it 'return the amount with deduced discount' do
          expect(subject.total).to eq(73.76)
        end
      end
    end
  end
end
