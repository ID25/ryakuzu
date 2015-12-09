module Ryakuzu
  class ApplicationController < ActionController::Base
    rescue_from Errno::ENOENT, with: :render_500

    private

    def render_500
      render template: 'ryakuzu/main/error_500', layout: 'ryakuzu/layouts/application', status: 500
    end
  end
end
