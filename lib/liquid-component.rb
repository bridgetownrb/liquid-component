require "liquid-component/version"

require "safe_yaml/load"
SafeYAML::OPTIONS[:suppress_warnings] = true

require "liquid-component/component"
require "liquid-component/metadata"
require "liquid-component/variable"

module LiquidComponent
  FRONT_MATTER_REGEXP = %r!\A(---\s*\n.*?\n?)^((---|\.\.\.)\s*$\n?)!m.freeze

  def self.parse(template)
    template = template.to_s

    yaml_data = {}
    file_content = nil

    if has_yaml_header?(template)
      if template = template.match(FRONT_MATTER_REGEXP)
        file_content = template.post_match
        yaml_data = SafeYAML.load(template.captures[0])
      end
    else
      file_content = template
    end

    Component.new(
      metadata: Metadata.new(yaml_data),
      content: file_content
    )
  end

  def self.has_yaml_header?(template)
    template.lines.first&.match? %r!\A---\s*\r?\n!
  end
end
