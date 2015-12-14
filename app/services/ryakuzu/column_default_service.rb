require_relative '../../../lib/ryakuzu/boolean_patch'

module Ryakuzu
  class ColumnDefaultService
    attr_reader :params, :default, :index, :null, :type, :table, :column,
                :old_null, :old_default, :parameters, :old_type

    def initialize(params)
      @params      = params
      @parameters  = params['parameters']
      @default     = params['default']
      @index       = params['index']
      @null        = params['null']
      @type        = params['type']
      @table       = params['table']
      @column      = params['column']
      @old_type    = params['parameters'][':old_type']
      @old_default = params['parameters'][':old_default']
    end

    def call
      processing_params
      current = params.reject { |k, _v| %w(table column).include? k }.except('parameters')

      zip = current.zip(params['parameters'])

      zip.each do |k, v|
        run_column_default_migration(k, table, column) if k[1] != v[1]
      end
    end

    private

    def processing_params
      # TODO: make index and null select
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

    def run_column_default_migration(type_column, tabl, kolumn)
      text = remove_column_text(tabl, kolumn, type_column)
      p tabl
      p kolumn
      p type_column

      Ryakuzu::RunMigration.new(table: tabl, column: kolumn).call(kolumn, text, 'column')
    end

    def remove_column_text(tabl, kolumn, type_column)
      type_kolumn = type_column[1].downcase.to_sym
      text        = "remove_column :#{tabl.tableize}, :#{kolumn}\n"
      text.concat "add_column :#{tabl.tableize}, :#{kolumn}, :#{type_kolumn}"
    end
  end
end
