module Ryakuzu
  class AddColumnService
    attr_reader :table, :column, :type

    def initialize(table, column, type)
      @table  = table
      @column = column
      @type   = type
    end

    def call
      text = text_migration
      Ryakuzu::RunMigration.new(new_column: column).call(table, text, 'table')
    end

    private

    def text_migration
      "add_column :#{table.tableize}, :#{column}, :#{type.downcase.to_sym}"
    end
  end
end
