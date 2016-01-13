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
      hash = to_hash(params)

      type, old_type, default, old_default = *hash.values

      run_full(type, default)        if type != old_type && default != old_default
      run_type(type, old_default)    if type != old_type && default == old_default
      run_default(old_type, default) if default != old_default && type == old_type
    end

    private

    def processing_params
      @default     = '' if default == "\"\""
      @old_default = '' if old_default == "\"\""
      type.gsub!('Current: ', '')
    end

    def to_hash(param)
      current = param.reject { |k, _v| %w(table column).include? k }.except('parameters')
      zip     = current.zip(params['parameters'])
      Hash[*zip.flatten]
    end

    def run_full(type, default)
      text = MigrationText.new(table, column, type, default).full_migration
      Ryakuzu::RunMigration.new(table: table, column: column).call(column, text, 'column')
    end

    def run_type(type, old_default)
      text = MigrationText.new(table, column, type, old_default).type_migration
      Ryakuzu::RunMigration.new(table: table, column: column).call(column, text, 'column')
    end

    def run_default(old_type, default)
      text = MigrationText.new(table, column, old_type, default).default_migration
      Ryakuzu::RunMigration.new(table: table, column: column).call(column, text, 'column')
    end
  end
end
