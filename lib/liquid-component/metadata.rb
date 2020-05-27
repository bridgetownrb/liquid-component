require "active_support/core_ext/hash/indifferent_access"

module LiquidComponent  
  class Metadata
    attr_accessor :name, :description, :variables, :additional

    def initialize(metadata)
      metadata = metadata.with_indifferent_access

      self.name = metadata[:name]
      self.description = metadata[:description]
      self.variables = Variable.parse(metadata[:variables])

      metadata.delete(:name)
      metadata.delete(:description)
      metadata.delete(:variables)

      self.additional = metadata
    end

    def to_h
      h = {}
      h[:name] = name if name
      h[:description] = description if description
      h[:variables] = variables.map(&:to_h)
      h[:additional] = additional

      h
    end
  end
end
