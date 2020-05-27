require "minitest/autorun"
require "minitest/reporters"
require "minitest/profile"
require "liquid-component"

# Report with color.
Minitest::Reporters.use! [
  Minitest::Reporters::DefaultReporter.new(
    color: true
  ),
]
