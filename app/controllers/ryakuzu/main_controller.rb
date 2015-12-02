module Ryakuzu
  class MainController < ApplicationController
    def index
      schema = Ryakuzu::SchemaService.new
      @schema = schema.hash.as_json
      render template: 'ryakuzu/main/index', layout: 'ryakuzu/layouts/application'
    end
  end
end
