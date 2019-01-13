# frozen_string_literal: true

module Promotions
  class BasePromotion
    def initialize(condition_fun:, discount_fun:)
      @condition_fun = condition_fun
      @discount_fun = discount_fun
    end

    def apply?(_arg)
      raise NotImplementedError, 'You must implement the apply? method'
    end

    def discount(_arg)
      raise NotImplementedError, 'You must implement the discount method'
    end

    private

    attr_reader :condition_fun, :discount_fun
  end
end
