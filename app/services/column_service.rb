class ColumnService
  attr_accessor :old_column, :new_column, :table
  require 'fileutils'

  def initialize(params, table)
    @old_column = params.keys.join('').underscore
    @new_column = params.values.join('').underscore
    @table      = table.underscore
  end

  def call
    date = DateTime.now.to_s(:number)
    class_name   = new_column.split('_').map { |i| i.titleize }.join('')
    migrate_name = "#{date}_change_column_#{new_column.split(' ').join('')}.rb"
    text =
    "class ChangeColumn#{class_name} < ActiveRecord::Migration
  def change
    rename_column :#{table}, :#{old_column}, :#{new_column}
  end
end"


    output = File.new("./db/migrate/#{migrate_name}", "a+")
    output << text
    output.close
    system 'rake db:migrate'
    File.delete(output)
  end
end
