# frozen_string_literal: true
require 'bundler/gem_tasks'
require 'rubocop/rake_task'

# Rake::Task['rubocop'].clear
RuboCop::RakeTask.new(:rubocop) do |task|
  task.formatters = %w(fuubar offenses)
  task.fail_on_error = true
end

task default: [:rubocop]
