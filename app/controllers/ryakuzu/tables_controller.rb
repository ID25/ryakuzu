module Ryakuzu
  class TablesController < ApplicationController
    respond_to :js

    def create
      # TODO: handle params
    end

    def column
      @column = params[:column]
      @table  = params[:table]
      @opts   = SchemaService.new.take_column(@table, @column)
      respond_with @opts
    end
  end
end
