module Ryakuzu
  class MigrationText
    attr_reader :table, :column, :type, :default, :text

    def initialize(table, column, type, default)
      @table   = table
      @column  = column
      @type    = type
      @default = default
      @text    = "remove_column :#{@table.tableize}, :#{@column}\n"
    end

    def full_migration
      default.empty? ? type_migration : default_migration
    end

    def type_migration
      text.concat "add_column :#{table.tableize}, :#{column}, :#{type.downcase}"
    end

    def default_migration
      val_def = create_full_text
      text.concat "add_column :#{table.tableize}, :#{column}, :#{type.downcase}, default: #{val_def}"
    end

    private

    def create_full_text
      arr = %w(Integer Float Decimal Binary Boolean)
      arr.any? { |e| e == type } ? "#{default}" : "'#{default}'"
    end
  end
end
