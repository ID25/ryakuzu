class ColumnService
  attr_accessor :old_column, :new_column, :table
  require 'fileutils'

  def initialize(params, table)
    @old_column = params.keys.join('')
    @new_column = params.values.join('')
    @table      = table.keys.join('')
  end

  def call
    text =
    "class ChangeColumn#{new_column.titleize.split(' ').join('')} < ActiveRecord::Migration
  def change
    rename_column :#{table}, :#{old_column}, :#{new_column}
  end
end"

    date = DateTime.now.to_s(:number)
    output = File.new("./db/migrate/#{date}_change_column_#{new_column}.rb", "a+")
    output << text
    output.close
    system 'rake db:migrate'
    File.delete(output)
  end
end
