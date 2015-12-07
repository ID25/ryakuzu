module Ryakuzu
  class AddColumnService
    attr_reader :table, :column, :type

    def initialize(table, column, type)
      @table  = table
      @column = column
      @type   = type
    end

    def call
      text = "add_column :#{table.tableize}, :#{column}, :#{type.downcase.to_sym}"
      Ryakuzu::RunMigration.new(new_column: column).call(table, text, 'table')
    end
  end
end
