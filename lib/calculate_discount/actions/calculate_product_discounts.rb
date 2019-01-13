# frozen_string_literal: true

module CalculateDiscount
  module Actions
    class CalculateProductDiscounts
      def initialize(products:, promotions:)
        @products = products
        @promotions = promotions
      end

      def call
        valid_promotions.map { |promotion| promotion.discount(products) }.sum
      end

      private

      attr_reader :products, :promotions

      def valid_promotions
        @valid_promotions ||= promotions.select { |promotion| promotion.apply?(products) }
      end
    end
  end
end
