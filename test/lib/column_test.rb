require 'test_helper'

class ColumnTest < ActiveSupport::TestCase
  test 'attributes' do
    column = Ryakuzu::Column.new(table: 'users', column: 'name', default: '', type: 'string', null: 'false')
    assert_equal column.null,     false
    assert_equal column.type,     'string'
    assert_equal column.table,    'users'
    assert_equal column.column,   'name'
    assert_equal column.default,  ''
  end

  test '#null' do
    ['false', '', nil, 0].each do |falsy|
      column = Ryakuzu::Column.new(null: falsy)
      assert_equal column.null, false
    end

    ['true'].each do |truthy|
      column = Ryakuzu::Column.new(null: truthy)
      assert_equal column.null, true
    end
  end
end
