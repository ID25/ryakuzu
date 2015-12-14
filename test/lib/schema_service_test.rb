require 'test_helper'

class SchemaServiceTest < ActiveSupport::TestCase
  schema_array = [%w(authorizations user_id provider uid created_at updated_at), %w(bags team_id created_at updated_at), %w(enemies health magic attack exp move created_at updated_at type user_id img_url coins), %w(items name item_params itemable_id itemable_type created_at updated_at used), %w(monsters team_id user_id name health magic created_at updated_at img_link attack exp level previous_health previous_magic armed item_id), %w(shops name created_at updated_at), %w(teams user_id name level created_at updated_at monsters_count monsters_limit exp move to_next_level), %w(users email encrypted_password reset_password_token reset_password_sent_at remember_created_at sign_in_count current_sign_in_at last_sign_in_at current_sign_in_ip last_sign_in_ip created_at updated_at coins)]

  test '#hash' do
    schema = Ryakuzu::SchemaService.new

    assert_equal schema.hash.map { |e| e.is_a?(Object) }[0], true
    assert_equal schema.hash.is_a?(Array), true
  end

  test '#convert_to_hash' do
    schema = Ryakuzu::SchemaService.new

    schema.send(:parse_schema)
    source = schema.send(:convert_source)

    assert_equal schema.send(:convert_to_hash, source), schema_array
  end

  test '#call' do
    schema = Ryakuzu::SchemaService.new

    assert_equal schema_array, schema.call
  end
end
