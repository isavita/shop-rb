# frozen_string_literal: true

require_relative 'action'

module CalculateDiscount
  class EntryPoint
    def self.call(promotions:, products:)
      CalculateDiscount::Action.new(promotions: promotions, products: products).call
    end
  end
end
