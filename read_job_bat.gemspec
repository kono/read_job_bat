
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "read_job_bat/version"

Gem::Specification.new do |spec|
  spec.name          = "read_job_bat"
  spec.version       = ReadJobBat::VERSION
  spec.authors       = ["Hiroshi Kono"]
  spec.email         = ["hiroshi.kono@gmail.com"]

  spec.summary       = %q{Read bat file and print its contents}
  spec.description   = %q{It analyzes bat file. It reads bat and print its contents}
  spec.homepage      = "https://github.com/kono/read_job_bat"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

    spec.metadata["homepage_uri"] = spec.homepage
    spec.metadata["source_code_uri"] = "https://github.com/kono/read_job_bat"
    spec.metadata["changelog_uri"] = "https://github.com/kono/raad_job_bat"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "test-unit", "~> 3.2.3"
end
