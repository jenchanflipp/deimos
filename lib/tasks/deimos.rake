# frozen_string_literal: true

require 'phobos'
require 'phobos/cli'
require 'generators/deimos/schema_class_generator'
require 'optparse'
require 'generators/deimos/active_record_consumer_generator'

namespace :deimos do
  desc 'Starts Deimos in the rails environment'
  task start: :environment do
    Deimos.configure do |config|
      config.producers.backend = :kafka if config.producers.backend == :kafka_async
    end
    ENV['DEIMOS_RAKE_TASK'] = 'true'
    STDOUT.sync = true
    Rails.logger.info('Running deimos:start rake task.')
    Phobos::CLI::Commands.start(%w(start --skip_config))
  end

  desc 'Starts the Deimos database producer'
  task db_producer: :environment do
    ENV['DEIMOS_RAKE_TASK'] = 'true'
    STDOUT.sync = true
    Rails.logger.info('Running deimos:db_producer rake task.')
    thread_count = ENV['THREAD_COUNT'].to_i.zero? ? 1 : ENV['THREAD_COUNT'].to_i
    Deimos.start_db_backend!(thread_count: thread_count)
  end

  task db_poller: :environment do
    ENV['DEIMOS_RAKE_TASK'] = 'true'
    STDOUT.sync = true
    Rails.logger.info('Running deimos:db_poller rake task.')
    Deimos::Utils::DbPoller.start!
  end

  desc 'Run Schema Model Generator'
  task generate_schema_classes: :environment do
    Rails.logger.info("Running deimos:generate_schema_classes")
    Deimos::Generators::SchemaClassGenerator.start
  end

  desc 'Run Interactive Consumer Generator'
  task generate_active_record_consumer: :environment do
    Rails.logger.info("Running deimos:generate_active_record_consumer")
    Deimos::Generators::ActiveRecordConsumerGenerator.start
  end

end
