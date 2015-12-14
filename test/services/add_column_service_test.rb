require 'test_helper'

class AddColumnServiceTest < ActiveSupport::TestCase
  test 'valid migration text' do
    migration = Ryakuzu::AddColumnService.new('users', 'email', 'string')

    except = 'add_column :users, :email, :string'
    assert_equal except, migration.send(:text_migration)
  end
end
