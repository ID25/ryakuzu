require 'test_helper'

class ColumnDefaultServiceTest < ActiveSupport::TestCase
  test 'migration text for string' do
    migration = Ryakuzu::MigrationText.new('users', 'available', 'string', true)

    except = "remove_column :users, :available\nadd_column :users, :available, :string, default: 'true'"
    assert_equal except, migration.default_migration
  end

  test 'migration text for type' do
    migration = Ryakuzu::MigrationText.new('users', 'available', 'Integer', '')

    except = "remove_column :users, :available\nadd_column :users, :available, :integer"
    assert_equal except, migration.type_migration
  end
end
