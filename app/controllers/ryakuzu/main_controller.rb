module Ryakuzu
  class MainController < RootController
    def index
      @schema = Ryakuzu::SchemaService.new.call.as_json
    rescue NoMethodError
      schema_error
    end

    private

    def schema_error
      render :schema_error
    end
  end
end
