class Column < Schema
  attr_accessor :default, :type, :null

  def initialize(hash = {})
    @default  = hash['default:']
    @type     = hash[:type]
    @null     = hash['null:']
  end

  def column_info
    ColumnDefaults.generate_object(default, type, null)
  end
end
