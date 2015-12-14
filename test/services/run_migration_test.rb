require 'test_helper'

class RunMigrationTest < ActiveSupport::TestCase
  test 'valid migration text' do
    migration = Ryakuzu::RunMigration.new(old_table: 'users', new_table: 'admin')

    text   = 'rename_table :users, :admins'
    except = "class ChangeTableUser < ActiveRecord::Migration
      def change
        #{text}
      end
    end"
    assert_equal except, migration.text_migration('table', 'User', text)
  end
end
