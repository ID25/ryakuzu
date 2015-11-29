class Column < Schema
  attr_accessor :hash, :table, :column, :default, :type, :null, :index

  def initialize(hash = {})
    @hash     = hash
    @table    = hash[:table]
    @column   = hash[:column]
    @default  = hash[:default]
    @type     = hash[:type]
    @null     = hash[:null]
    @index    = hash[:index]
  end

  def column_info
    index = check_index
    ColumnDefaults.generate_object(table, column, default, type, null, index)
  end

  private

  def check_index
    @index = index.split
    index_hash = index.each_with_object(Hash.new(0)) { |i, hash| hash[i] = i }
    h2 = hash.reject! { |_k, v| v.nil? }
    (index_hash && h2) ? (index_hash['products'] == h2[:table] && index_hash['user_id'] == h2[:column]) : (false)
  end
end
