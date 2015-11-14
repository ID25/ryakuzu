class TableService
  attr_accessor :old_table, :new_table
  require 'fileutils'

  def initialize(params)
    @old_table = params.keys.join('')
    @new_table = params.values.join('')
  end

  def call
    text =
    "class ChangeTable#{new_table.titleize.split(' ').join('')} < ActiveRecord::Migration
  def change
    rename_table :#{old_table}, :#{new_table}
  end
end"

    date = DateTime.now.to_s(:number)
    output = File.new("./db/migrate/#{date}_change_table_#{new_table}.rb", "a+")
    output << text
    output.close
    system 'rake db:migrate'
    File.delete(output)
  end
end
