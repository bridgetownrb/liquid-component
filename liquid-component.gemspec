require_relative "lib/liquid-component/version"

Gem::Specification.new do |spec|
  spec.name          = "liquid-component"
  spec.version       = LiquidComponent::VERSION
  spec.authors       = ["Jared White"]
  spec.email         = ["jared@whitefusion.io"]

  spec.summary       = %q{Load and parse Liquid Component templates which include front matter}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/bridgetownrb/liquid-component"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(script|test|spec|features)/}) }
  end
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport", ">= 5.0"
  spec.add_runtime_dependency "safe_yaml", "~> 1.0"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "minitest-profile", ">= 0.0.2"
  spec.add_development_dependency "minitest-reporters", "~> 1.0"
end
