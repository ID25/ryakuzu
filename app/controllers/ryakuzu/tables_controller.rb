module Ryakuzu
  class TablesController < ApplicationController
    respond_to :js

    def create
      @param    = params[:table]
      redirect_to :back
    end

    def column
      @column = params[:column]
      @table  = params[:table]
      @opts   = SchemaService.new.take_column(@table, @column)
      respond_with @opts
    end
  end
end
