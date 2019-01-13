# frozen_string_literal: true

require_relative 'base_promotion'

module Promotions
  class GeneralPromotion < BasePromotion
    def apply?(amount)
      condition_fun.call(amount)
    end

    def discount(amount)
      discount_fun.call(amount)
    end
  end
end
