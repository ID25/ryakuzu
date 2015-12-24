module Ryakuzu
  class TableService
    attr_accessor :old_table, :new_table

    def initialize(old_table, new_table)
      @old_table = old_table
      @new_table = new_table
    end

    def call
      text = text_migration
      Ryakuzu::RunMigration.new(old_table: old_table, new_table: new_table.tableize).call(new_table.tableize, text, 'table')
    end

    def text_migration
      "rename_table :#{old_table}, :#{new_table.tableize}"
    end
  end
end
