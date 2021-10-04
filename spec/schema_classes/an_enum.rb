# frozen_string_literal: true

# This file is autogenerated by Deimos, Do NOT modify
module Deimos
  # :nodoc:
  class AnEnum < SchemaClass::Enum
    # @return ['sym1', 'sym2']
    attr_accessor :an_enum

    # :nodoc:
    def initialize(an_enum)
      super()
      self.an_enum = an_enum
    end

    # @override
    def symbols
      %w(sym1 sym2)
    end

    # @override
    def to_h
      @an_enum
    end
  end
end
