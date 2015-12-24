require 'slim-rails'
require_relative 'libs'

module Ryakuzu
  class Engine < ::Rails::Engine
    isolate_namespace Ryakuzu
    config.autoload_paths += %W(#{config.root}/lib)

    initializer 'Add routes', before: :load_config_initializers do |_app|
      Rails.application.routes.append do
        mount Ryakuzu::Engine, at: '/ryakuzu'
      end
    end
  end
end
