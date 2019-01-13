# frozen_string_literal: true

module CalculateDiscount
  module Actions
    class CalculateGeneralDiscounts
      def initialize(amount:, promotions:)
        @amount = amount
        @promotions = promotions
      end

      def call
        valid_promotions.map { |promotion| promotion.discount(amount) }.sum
      end

      private

      attr_reader :amount, :promotions

      def valid_promotions
        @valid_promotions ||= promotions.select { |promotion| promotion.apply?(amount) }
      end
    end
  end
end
