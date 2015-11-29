class TableService
  attr_accessor :old_table, :new_table

  def initialize(old_table, new_table)
    @old_table = old_table
    @new_table = new_table
  end

  def call
    text = "rename_table :#{old_table}, :#{new_table}"
    RunMigration.new(old_table: old_table, new_table: new_table).call(new_table, text, 'table')
  end
end
