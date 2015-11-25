module Ryakuzu
  class MainController < ApplicationController
    def index
      schema = SchemaService.new
      @schema = schema.hash.as_json
      render template: 'ryakuzu/main/index', layout: 'ryakuzu/layouts/application'
    end

    def update_hash
      if params[:table]
        table = TableService.new(params[:table])
        table.call
      elsif params[:column]
        column = ColumnService.new(params[:column], params[:info])
        column.call
      end
      redirect_to action: :index
    end
  end
end
