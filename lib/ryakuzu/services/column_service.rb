module Ryakuzu
  class ColumnService
    attr_accessor :old_column, :new_column, :table

    def initialize(old_column, new_column, table)
      @old_column = old_column
      @new_column = new_column
      @table      = table
    end

    def call
      text = text_migration
      Ryakuzu::RunMigration.new(old_column: old_column, new_column: new_column).call(new_column, text, 'column')
    end

    private

    def text_migration
      "rename_column :#{table.tableize}, :#{old_column}, :#{new_column}"
    end
  end
end
