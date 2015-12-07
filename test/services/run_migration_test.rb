require 'test_helper'

class RunMigrationTest < ActiveSupport::TestCase
  migration = Ryakuzu::RunMigration.new(old_table: 'users', new_table: 'admin')

  test 'valid migration text' do
    text   = 'rename_table :users, :admins'
    except = "class ChangeTableUser < ActiveRecord::Migration
      def change
        #{text}
      end
    end"
    assert_equal except, migration.text_migration('table', 'User', text)
  end
end
