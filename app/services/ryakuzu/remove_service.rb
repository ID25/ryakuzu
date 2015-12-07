module Ryakuzu
  class RemoveService
    attr_reader :table, :column

    def initialize(**options)
      @table  = options[:table]
      @column = options[:column]
    end

    def call
      column.blank? ? run_drop_table_migration : run_remove_column_migration
    end

    private

    def run_remove_column_migration
      text = "remove_column :#{table}, :#{column}"
      Ryakuzu::RunMigration.new(old_table: table, old_column: column).call(column, text, 'column')
    end

    def run_drop_table_migration
      text = "drop_table :#{table}"
      Ryakuzu::RunMigration.new(old_table: table).call(table, text, 'table')
    end
  end
end
