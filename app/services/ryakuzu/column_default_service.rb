require_relative '../../../lib/ryakuzu/boolean_patch'

module Ryakuzu
  class ColumnDefaultService
    attr_reader :option, :option_two, :table, :column

    def initialize(params)
      p params
    end

    def call
      p table
      processing_param
      current = params[:parameters].reject { |k, _v| [':table', ':column'].include? k }


      zip = current.zip(params.except(:parameters))
      zip.each do |k, v|
        run_column_default_migration(k[1], v[1], table, column) if k[1] != v[1]
      end
    end

    private

    def processing_param
      [[null, 'null'], [index, 'index']].each do |key, val|
        key.to_bool ? (params[val] = true) : (params[val] = false)
      end
      params['default'] = '' if params['default'] == "\"\""
      params['parameters'][':old_default'] = '' if params['parameters'][':old_default'] == "\"\""
      params['parameters'][':old_null'].to_bool ? (params['parameters'][':old_null'] = true) : (params['parameters'][':old_null'] = false)
      params['type'].gsub!('Current: ', '')
    end
  end
end
