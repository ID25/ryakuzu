class Schema
  require 'virtus/relations'
  include Virtus.model
  include ActiveModel::Conversion
  extend  ActiveModel::Naming

  def persisted?
  end
end
