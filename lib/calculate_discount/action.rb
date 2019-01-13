# frozen_string_literal: true

require_relative 'actions/calculate_product_discounts'
require_relative 'actions/calculate_general_discounts'
require_relative '../promotions/product_promotion'
require_relative '../promotions/general_promotion'

module CalculateDiscount
  class Action
    def initialize(promotions:, products:)
      @promotions = promotions
      @products = products
    end

    def call
      product_discount + general_discount(amount - product_discount)
    end

    private

    attr_reader :promotions, :products

    def amount
      @amount ||= products.sum(&:price)
    end

    def product_discount
      @product_discount ||= CalculateDiscount::Actions::CalculateProductDiscounts.new(
        products: products, promotions: product_promotions
      ).call
    end

    def general_discount(amount)
      CalculateDiscount::Actions::CalculateGeneralDiscounts.new(
        amount: amount, promotions: general_promotions
      ).call
    end

    def product_promotions
      @product_promotions ||= promotions.select { |promotion| promotion.is_a?(Promotions::ProductPromotion) }
    end

    def general_promotions
      @general_promotions ||= promotions.select { |promotion| promotion.is_a?(Promotions::GeneralPromotion) }
    end
  end
end
