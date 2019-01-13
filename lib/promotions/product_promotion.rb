# frozen_string_literal: true

require_relative 'base_promotion'

module Promotions
  class ProductPromotion < BasePromotion
    def apply?(products)
      condition_fun.call(products)
    end

    def discount(products)
      discount_fun.call(products)
    end
  end
end
