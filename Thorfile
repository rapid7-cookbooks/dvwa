# encoding: utf-8

require 'berkshelf/thor'
require 'bundler'
require 'bundler/setup'
require 'foodcritic'
require 'thor/rake_compat'

class Default < Thor
  include Thor::RakeCompat

  FoodCritic::Rake::LintTask.new

  desc 'foodcritic', 'Lint Chef cookbooks'
  def foodcritic
    Rake::Task['foodcritic'].execute
  end
end
