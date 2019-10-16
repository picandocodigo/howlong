# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'howlong/version'

Gem::Specification.new do |spec|
  spec.name          = 'howlong'
  spec.version       = Howlong::VERSION
  spec.authors       = ['Fernando Briano']
  spec.email         = ['fernando@picandocodigo.net']
  spec.summary       = " Search for a process and display how long it's been running on your system in a friendly way"
  spec.description   = ' A simple gem which allows you to see how long a process has been running on your system in a friendly way'
  spec.homepage      = 'https://github.com/picandocodigo/howlong'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'byebug'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'timecop'

  spec.metadata      = {
    "bug_tracker_uri"   => "https://github.com/picandocodigo/howlong/issues",
    "changelog_uri"     => "https://github.com/picandocodigo/howlong/blob/master/CHANGELOG.md",
    "documentation_uri" => "https://github.com/picandocodigo/howlong/blob/master/README.md",
    "homepage_uri"      => "https://github.com/picandocodigo/howlong",
    "source_code_uri"   => "https://github.com/picandocodigo/howlong"
  }
end
