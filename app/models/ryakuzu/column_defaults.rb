module Ryakuzu
  class ColumnDefaults < Schema
    attr_accessor :table, :column, :default, :type, :null, :index

    attribute :table,   String
    attribute :column,  String
    attribute :default, String
    attribute :type,    String
    attribute :null,    String
    attribute :index,   Boolean

    def initialize(hash, null)
      hash.each { |key, val| send("#{key}=", val) }
      self.null    = null
      self.null    = 'none' unless null
      self.default = '""' if default == ""
    end
  end
end
