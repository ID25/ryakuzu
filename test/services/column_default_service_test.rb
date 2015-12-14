require 'test_helper'

class ColumnDefaultServiceTest < ActiveSupport::TestCase
  test 'valid migration text' do
    migration = Ryakuzu::ColumnDefaultService.new('table' => 'users', 'column' => 'accepted', 'type' => 'Boolean', 'parameters' => { ':old_type' => 'string' })

    except = "remove_column :users, :accepted\nadd_column :users, :accepted, :boolean"
    assert_equal except, migration.send(:remove_column_text, 'users', 'accepted', %w(type Boolean))
  end
end
