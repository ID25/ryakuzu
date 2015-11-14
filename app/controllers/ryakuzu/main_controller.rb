module Ryakuzu
  class MainController < ApplicationController
    def index
      schema = SchemaService.new
      @view = schema.hash
    end

    def update_hash
      if params[:table_name]
        table = TableService.new(params[:table_name])
        table.call
      elsif params[:column_info]
        column = ColumnService.new(params[:column_info], params[:table_info])
        column.call
      end
      redirect_to :back
    end
  end
end
