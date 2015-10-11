require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-syntax/tasks/puppet-syntax'
require 'puppet-lint/tasks/puppet-lint'

repo_dir = File.dirname(__FILE__)

ignore_paths = [
  'pkg/**/*.pp',
  'spec/**/*.pp',
  'tests/**/*.pp',
]

Rake::Task[:spec].clear
task :spec do
  Rake::Task[:spec_prep].invoke
  Rake::Task[:spec_standalone].invoke
end


Rake::Task[:lint].clear
PuppetLint::RakeTask.new :lint do |config|
  # Pattern of files to ignore
  config.ignore_paths = ignore_paths

  # List of checks to disable
  config.disable_checks = [
    '80chars',
    'class_inherits_from_params_class',
    'documentation',
  ]

  # Should the task fail if there were any warnings, defaults to false
  config.fail_on_warnings = true

  # Print out the context for the problem, defaults to false
  config.with_context = true

  # Format string for puppet-lint's output (see the puppet-lint help output
  # for details
  config.log_format = "%{path}:%{linenumber}:%{check}:%{KIND}:%{message}"

  # Compare module layout relative to the module root
  # config.relative = true
end

PuppetSyntax.exclude_paths = ignore_paths

task :default => [
  :syntax,
  :lint,
  :spec,
]

## Why not
task :future do |args|
  PuppetSyntax.future_parser = true
  Rake::Task[:syntax].invoke
end

desc "Populate CONTRIBUTORS file"
task :contributors do
    system("git log --format='%aN, %aE' | sort -u > CONTRIBUTORS")
end

namespace :init do
  task :bundler do
    puts "=> Running 'bundle install'"
    sh("bundle", "install")
  end

  task :hooks do
    puts "=> Copying git hooks to ./.git/hooks/"
    sh("cp -rf #{repo_dir}/.githooks/* #{repo_dir}/.git/hooks")
  end
end

task :init do
  Rake::Task['init:bundler'].invoke
  Rake::Task['init:hooks'].invoke

  puts
  puts "======================================================================"
  puts "Repo initialized"
  puts
  puts "You should now have a development environment setup."
  puts "Execute 'rake -T' to see the available rake tasks."
  puts "  For example:  rake syntax"
  puts
  puts "pre-commit hooks for Git were also initialized. Whenever you commit,"
  puts "your changes will be validated against puppet syntax, puppet-lint,"
  puts "and Ruby validation (erb, yaml, json)."
end
