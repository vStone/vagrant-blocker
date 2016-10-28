# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vagrant_blocker/version'

Gem::Specification.new do |spec|
  spec.name           = 'vagrant-blocker'
  spec.version        = VagrantPlugins::Blocker::VERSION
  spec.authors        = ['Jan Vansteenkiste']
  spec.email          = ['jan@vstone.eu']
  spec.summary        = 'Allow certain virtual machines to block eachother'
  spec.description    = 'Prevents certain machines in a multi-vm setup from running together'
  spec.homepage       = 'https://github.com/vStone/vagrant-blocker'
  spec.license        = 'MIT'

  spec.files          = `git ls-files -z`.split("\x0") - ['.gitignore', '.rubocop.yml', 'Rakefile', 'Gemfile']
  spec.executables    = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files     = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths  = ['lib']
end
