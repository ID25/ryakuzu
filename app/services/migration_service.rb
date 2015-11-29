class MigrationService
  attr_accessor :columns, :table, :old_table

  def initialize(params)
    @columns   = params['column']
    @table     = params['name']
    @old_table = params['old_name']
  end

  def call
    run_table_migration(old_table, table) if table != old_table

    columns.each_slice(2) do |k, v|
      run_column_migration(v[1], k[1], table) if k[1] != v[1]
    end
  end

  private

  def run_table_migration(old_table, new_table)
    TableService.new(old_table, new_table).call
  end

  def run_column_migration(old_name, new_name, table)
    ColumnService.new(old_name, new_name, table).call
  end
end
