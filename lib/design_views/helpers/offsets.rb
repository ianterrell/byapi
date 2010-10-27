module DesignViews
  module Helpers
    class Offsets
      def initialize(offsets, width)
        @offsets = Hash.new(Hash.new(0)).merge(offsets || {})
        puts @offsets.inspect
        @width = width
      end
      
      def x(key)
        offset_for(key,"x")
      end
      
      def y(key)
        offset_for(key,"y")
      end
      
      def offset_for(key,axis)
        puts (@offsets[key][axis] || 0).to_f / 300 * @width
        (@offsets[key][axis] || 0).to_f / 300 * @width
      end
    end
  end
end