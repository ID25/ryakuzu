require 'test_helper'

class ColumnServiceTest < ActiveSupport::TestCase
  test 'valid migration text' do
    migration = Ryakuzu::ColumnService.new('accepted', 'aviable', 'product')

    except = 'rename_column :products, :accepted, :aviable'
    assert_equal except, migration.send(:text_migration)
  end
end
