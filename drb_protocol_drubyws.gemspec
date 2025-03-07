# frozen_string_literal: true

require_relative "lib/drb_web_socket/version"

Gem::Specification.new do |spec|
  spec.name = "drb_protocol_drubyws"
  spec.version = DRbWebSocket::VERSION
  spec.authors = ["shigeru.nakajima"]
  spec.email = ["shigeru.nakajima@gmail.com"]
  spec.license = "MIT"

  spec.summary = "A protocol with WebSocket for drb."
  spec.description = "A transport protocol for dRuby that uses WebSocket. It enables connections from a browser to a dRuby server."
  spec.homepage = "https://github.com/ledsun/drb_web_socket"
  spec.required_ruby_version = ">= 3.1.0"

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "drb", "~> 2.2"
  spec.add_dependency "wands", "~> 0.6"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata["rubygems_mfa_required"] = "true"
end
