module Ryakuzu
  class MainController < ApplicationController
    def index
      schema = SchemaService.new
      @view = schema.hash
    end

    def update_hash
      p 'hello'
      redirect_to :back
    end
  end
end
