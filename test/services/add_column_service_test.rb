require 'test_helper'

class AddColumnServiceTest < ActiveSupport::TestCase
  migration = Ryakuzu::AddColumnService.new('users', 'email', 'string')

  test 'valid migration text' do
    except = 'add_column :users, :email, :string'
    assert_equal except, migration.send(:text_migration)
  end
end
