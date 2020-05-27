module LiquidComponent
  class Component
    attr_accessor :metadata, :content

    def initialize(metadata:, content:)
      self.metadata = metadata
      self.content = content
    end

    def name
      metadata.name
    end

    def description
      metadata.description
    end

    def variables
      metadata.variables
    end

    def additional_metadata
      metadata.additional
    end

    def to_h
      {
        metadata: metadata.to_h,
        content: content
      }
    end
  end
end