require 'test_helper'

class ColumnInfoTest < ActiveSupport::TestCase
  column_info = Ryakuzu::ColumnInfo.new
  test '#remove_extra_chars' do
    except = ['my_table_name']
    result = column_info.send(:remove_extra_chars, ["my_tab%$le_\sname"])
    assert_equal except, result
  end

  test '#column_and_type' do
    except = { table: 'products', type: 'boolean', column: 'accepted' }
    result = column_info.send(:column_and_type, %w(boolean accepted), 'products')
    assert_equal except, result
  end

  test '#make_hash' do
    hash   = %w(default 0 null false)
    except = { 'default' => '0', 'null' => 'false' }
    result = column_info.send(:make_hash, hash)
    assert_equal except, result
  end
end
