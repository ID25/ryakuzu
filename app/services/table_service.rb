class TableService
  attr_accessor :old_table, :new_table
  require 'fileutils'

  def initialize(params)
    @old_table = params.keys.join('').underscore
    @new_table = params.values.join('').underscore
  end

  def call
    date = DateTime.now.to_s(:number)
    class_name   = new_table.titleize.split(' ').join('')
    migrate_name = "#{date}_change_table_#{new_table}.rb"
    text =
    "class ChangeTable#{class_name} < ActiveRecord::Migration
  def change
    rename_table :#{old_table}, :#{new_table}
  end
end"

    output = File.new("./db/migrate/#{migrate_name}", "a+")
    output << text
    output.close
    system 'rake db:migrate'
    File.delete(output)
  end
end
