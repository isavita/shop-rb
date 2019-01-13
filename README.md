# Shop checkout

## Setup

  * Use ruby 2.5.3 (see .ruby-version)
  * Install gems with `bundle install`
  * Run the test with `rspec`
  * Run rubocop with `rubocop`

## Design

  * **lib/promotions/base_promotion.rb** - defines the two methods (`apply?` and `discount`) that each promotion
    should implement.
  * **lib/promotions/product_promotion.rb** - inherit from `BasePromotion` and it is used for all promotions that are for products.
  * **lib/promotions/general_promotion.rb** - inherit from `BasePromotion` and it is used for all promotions that are
    base on the spent amount by the client.
  * **lib/calculate_discount/entry_point.rb** - defines one unit that calculates all the discounts which apply for
    given basket of products and group of promotions.
  * **lib/calculate_discount/action.rb** - invokes the sub-actions needed for calculating the total discount.
  * **lib/calculate_discount/actions/calculate_product_discounts.rb** - calculates all discount for products.
  * **lib/calculate_discount/actions/calculate_general_discounts.rb** - calculates all discount that are base on spent amount.
  * **lib/product.rb** - simple class that representing product from the shop.
  * **lib/checkout.rb** - simple class that uses the promotions and all of the scanned so far items to calculate the
    total amount that the client needs to pay.

