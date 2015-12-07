module Ryakuzu
  class TablesController < ApplicationController
    respond_to :js

    def create
      result = Ryakuzu::MigrationService.new(params[:table]).call
      respond_with result
    end

    def column
      @column = params[:column]
      @table  = params[:table]
      @opts   = Ryakuzu::ColumnInfo.new.call(@table, @column)
      respond_with @opts
    end

    def column_options
      result = Ryakuzu::ColumnDefaultService.new(params[:column_defaults]).call
      respond_with result
    end

    def remove_column
      result = Ryakuzu::RemoveService.new(table: params[:table], column: params[:column]).call
      respond_with result
    end

    def remove_table
      result = Ryakuzu::RemoveService.new(table: params[:table]).call
      redirect_to :back, notice: result
    end

    def add_column_form
      @table = params[:table]
      respond_with @table
    end

    def add_column
      table   = params[:table]
      column  = params[:name]['column']
      type    = params[:type]
      result  = Ryakuzu::AddColumnService.new(table, column, type).call
      respond_with result
    end

    def add_table;  end
    def new_column; end

    def save_csv
      schema = Ryakuzu::SchemaService.new
      schema.call
      schema.schema_to_csv
      send_file('schema.csv')
      schema.remove_csv
    end

    def create_table
      result = Ryakuzu::CreateTableService.new(params[:table], params[:column], params[:type]).call
      respond_with result
    end
  end
end
