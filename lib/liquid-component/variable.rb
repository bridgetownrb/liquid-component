module LiquidComponent  
  class Variable
    attr_accessor :name, :type, :required, :description

    def self.parse(variables)
      return [] if variables.nil?

      variables.map do |variable_name, variable_metadata|
        new(variable_name, variable_metadata)
      end
    end

    def initialize(variable_name, variable_metadata)
      self.required = true

      self.name = if variable_name.end_with? "?"
        self.required = false
        variable_name.sub(/\?$/, "").to_sym
      else
        variable_name.to_sym
      end

      if variable_metadata.is_a?(Array)
        self.type = variable_metadata[0].to_sym
        self.description = variable_metadata[1]
      else
        self.type = variable_metadata.to_sym
      end
    end

    def to_h
      h = {
        name: name,
        type: type,
        required: required
      }
      h[:description] = description if description

      h
    end
  end
end
