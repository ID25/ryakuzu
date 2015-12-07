require 'test_helper'

class TableServiceTest < ActiveSupport::TestCase
  migration = Ryakuzu::TableService.new('users', 'admin')

  test 'raise error, when table exists, or table have reference' do
    assert_equal "Cannot drop table, maybe it has reference to other tables? Find admin_id in other tables and remove it.", migration.call
  end

  test 'return valid text for migration' do
    assert_equal 'rename_table :users, :admins', migration.text_migration
  end
end
