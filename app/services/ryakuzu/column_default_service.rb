require_relative '../../../lib/ryakuzu/boolean_patch'

module Ryakuzu
  class ColumnDefaultService
    attr_reader :params, :default, :index, :null, :type, :table, :column, :old_null, :old_default, :parameters

    def initialize(params)
      @params      = params
      @parameters  = params['parameters']
      @default     = params['default']
      @index       = params['index']
      @null        = params['null']
      @type        = params['type']
      @table       = params['parameters'][':table']
      @column      = params['parameters'][':column']
      @old_null    = params['parameters'][':old_null']
      @old_default = params['parameters'][':old_default']
    end

    def call
      processing_param
      current = parameters.reject { |k, _v| [':table', ':column'].include? k }

      zip = current.zip(params.except('parameters'))
      zip.each do |k, v|
        alert(k, v, table, column) if k[1] != v[1]
      end
    end

    private

    def processing_param
      [null, index, old_null].each do |key|
        case key
        when 'none' then 'none'
        when true   then true
        when false  then false
        end
      end

      @default     = '' if default == "\"\""
      @old_default = '' if old_default == "\"\""
      type.gsub!('Current: ', '')
    end

    def alert(opt, opt2, tabl, kolumn)
      p opt
      p opt2
    end
  end
end
