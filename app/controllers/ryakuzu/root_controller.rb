module Ryakuzu
  class RootController < ActionController::Base
    layout 'ryakuzu/layouts/application'

    rescue_from Errno::ENOENT, with: :render_500
    helper_method :schema_present?

    private

    def render_500
      render template: 'ryakuzu/main/error_500', status: 500
    end

    def schema_present?
      File.file?('db/schema.rb')
    end
  end
end
