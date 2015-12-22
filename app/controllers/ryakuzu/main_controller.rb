module Ryakuzu
  class MainController < RootController
    def index
      schema = Ryakuzu::SchemaService.new
      @schema = schema.call.as_json
      render template: 'ryakuzu/main/index', layout: 'ryakuzu/layouts/application'
    end
  end
end
