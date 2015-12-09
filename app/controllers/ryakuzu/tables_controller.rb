module Ryakuzu
  class TablesController < ApplicationController
    def create
      result = Ryakuzu::MigrationService.new(params[:table]).call
      respond_with result
    end

    def column
      @column = params[:column]
      @table  = params[:table]
      @opts   = Ryakuzu::ColumnInfo.new.call(@table, @column)
      responds
    end

    def column_options
      Ryakuzu::ColumnDefaultService.new(params[:column_defaults]).call
      responds
    end

    def remove_column
      Ryakuzu::RemoveService.new(table: params[:table], column: params[:column]).call
      responds
    end

    def remove_table
      result = Ryakuzu::RemoveService.new(table: params[:table]).call
      redirect_to :back, notice: result
    end

    def add_column_form
      params[:table]
      responds
    end

    def add_column
      table   = params[:table]
      column  = params[:name]['column']
      type    = params[:type]
      Ryakuzu::AddColumnService.new(table, column, type).call
      responds
    end

    def add_table;  end

    def new_column; end

    def save_csv
      schema = Ryakuzu::SchemaService.new
      schema.call
      schema.schema_to_csv
      File.open('schema.csv', 'r') do |f|
        send_data f.read, type: 'text/csv', filename: 'schema.csv'
      end
      File.delete('schema.csv')
    end

    def create_table
      Ryakuzu::CreateTableService.new(params[:table], params[:column], params[:type]).call
      responds
    end

    private

    def responds
      respond_to do |format|
        format.js
      end
    end
  end
end
