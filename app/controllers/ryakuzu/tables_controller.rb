module Ryakuzu
  class TablesController < ApplicationController
    respond_to :js

    def create
      parameters = params[:table]
      migration  = Ryakuzu::MigrationService.new(parameters)
      migration.call
      redirect_to :back
    end

    def column
      @column = params[:column]
      @table  = params[:table]
      @opts   = Ryakuzu::ColumnInfo.new.call(@table, @column)
      respond_with @opts
    end

    def column_options
      parameters = params[:column_defaults]
      migration  = Ryakuzu::ColumnDefaultService.new(parameters)

      redirect_to :back
    end
  end
end
