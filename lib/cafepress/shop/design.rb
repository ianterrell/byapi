require 'happymapper'

module Cafepress
  module Shop
    class Design
      include HappyMapper
      tag 'design'

      attribute :value, String, :tag => 'value'
      attribute :svg, String, :tag => 'svg'
    end
  end
end