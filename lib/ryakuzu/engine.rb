require 'slim-rails'
require_relative 'libs'

module Ryakuzu
  class Engine < ::Rails::Engine
    isolate_namespace Ryakuzu

    initializer 'Add routes', before: :load_config_initializers do |_app|
      Rails.application.routes.append do
        mount Ryakuzu::Engine, at: '/ryakuzu'
      end
    end
  end
end
