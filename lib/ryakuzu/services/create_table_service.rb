module Ryakuzu
  class CreateTableService
    attr_reader :table, :column, :type

    def initialize(table, column, type)
      @table  = table['name']
      @column = column
      @type   = type
    end

    def call
      invoke_migration
    end

    private

    def invoke_migration
      return if column.blank? || type.blank? || table.blank?
      res    = column.zip(type)
      hash   = Hash[*res.flatten]
      string = make_string(hash)
      text = "rails g model #{table.classify} #{string} && rake db:migrate"
      system text
    end

    def make_string(hash)
      str = ''
      hash.each do |key, value|
        str += key + ':' + value.downcase + ' ' if value
      end
      str
    end
  end
end
