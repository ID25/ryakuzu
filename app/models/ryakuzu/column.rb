module Ryakuzu
  class Column < Schema
    attr_accessor :hash, :table, :column, :default, :type, :null, :index

    def initialize(hash = {})
      @hash     = hash
      @table    = hash[:table]
      @column   = hash[:column]
      @default  = hash[:default]
      @type     = hash[:type]
      @null     = to_bool(hash[:null])
    end

    def column_defaults
      Ryakuzu::ColumnDefaults.new(hash, null)
    end

    private

    def to_bool(value)
      String(value) == 'true'
    end
  end
end
