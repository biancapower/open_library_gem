# frozen_string_literal: true

require_relative "lib/open_library/version"

Gem::Specification.new do |spec|
  spec.name = "open_library"
  spec.version = OpenLibrary::VERSION
  spec.authors = ["Bianca Power"]
  spec.email = ["bianca@biancapower.com"]

  spec.summary = "A gem to work with the Open Library API"
  # spec.description = "Write a longer description or delete this line."
  spec.homepage = "https://github.com/biancapower/open_library_gem"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.6.0"

  # spec.metadata["allowed_push_host"] = "https://example.com"

  spec.metadata["homepage_uri"] = "https://github.com/biancapower/open_library_gem"
  spec.metadata["source_code_uri"] = "https://github.com/biancapower/open_library_gem"
  spec.metadata["changelog_uri"] = "https://example.com/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:bin|test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.files.reject! { |file| file =~ /\.gem$/ }

  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Dependencies
  spec.add_dependency 'httparty', '~> 0.21.0'
  spec.add_dependency 'json', '~> 2.6', '>= 2.6.3'

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
