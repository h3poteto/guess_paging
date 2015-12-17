# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'guess_paging/version'

Gem::Specification.new do |spec|
  spec.name          = "guess_paging"
  spec.version       = GuessPaging::VERSION
  spec.authors       = ["h3poteto"]
  spec.email         = ["h3.poteto@gmail.com"]

  spec.summary       = %q{Pagination for many records}
  spec.description   = %q{Pagination for rails when to treat many records or big table in RDB.}
  spec.homepage      = "https://github.com/h3poteto/guess_paging"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    #spec.metadata['allowed_push_host'] = "git@github.com:h3poteto/guess_paging"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"

  spec.add_dependency "redis", "~> 3.2"
end
