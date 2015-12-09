require 'slim-rails'

module Ryakuzu
  class Engine < ::Rails::Engine
    isolate_namespace Ryakuzu
    config.autoload_paths += %W(#{config.root}/lib)
  end
end
