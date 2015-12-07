module Ryakuzu
  class RunMigration
    attr_accessor :old_table, :new_table, :old_column, :new_column
    require 'fileutils'

    def initialize(options = {})
      @old_table  = options[:old_table]
      @new_table  = options[:new_table]
      @old_column = options[:old_column]
      @new_column = options[:new_column]
    end

    def call(migration, text_line, type)
      date = DateTime.now.to_s(:number)
      class_name   = migration.classify
      migrate_name = "#{date}_change_#{type}_#{class_name.underscore}.rb"
      text =
      "class Change#{type.titleize}#{class_name} < ActiveRecord::Migration
    def change
      #{text_line}
    end
  end"
      migration(migrate_name, text, class_name)
    end

    private

    def migration(migrate, text_migration, klass)
      output = File.new("./db/migrate/#{migrate}", 'a+')
      output << text_migration
      output.close
      result = system 'rake db:migrate'
      File.delete(output)
      fail StandardError if result == false
    rescue StandardError
      "Cannot drop table, maybe it has reference to other tables? Find #{klass.singularize.downcase}_id in other tables and remove it."
    end
  end
end
