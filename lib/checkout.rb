# frozen_string_literal: true

require_relative 'calculate_discount/entry_point'

class Checkout
  attr_reader :products

  def initialize(promotions, calculate_discount_class = CalculateDiscount::EntryPoint)
    @promotions = promotions
    @calculate_discount_class = calculate_discount_class
    @products = []
  end

  def total
    (total_amount - calculate_discount).round(2)
  end

  def scan(product)
    products.push(product)
  end

  private

  attr_reader :promotions, :calculate_discount_class

  def total_amount
    products.sum(&:price)
  end

  def calculate_discount
    calculate_discount_class.call(promotions: promotions, products: products)
  end
end
