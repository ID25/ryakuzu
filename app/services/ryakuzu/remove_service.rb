module Ryakuzu
  class RemoveService
    attr_reader :table, :column

    def initialize(table, column)
      @table  = table
      @column = column
    end

    def call
      run_remove_column_migration
    end

    private

    def run_remove_column_migration
      text = "remove_column :#{table}, :#{column}"
      Ryakuzu::RunMigration.new(old_table: table, old_column: column).call(column, text, 'column')
    end
  end
end
