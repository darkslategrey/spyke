require 'test_helper'

module Spike
  class CustomRequestTest < MiniTest::Test
    def test_custom_get_request_from_class
      endpoint = stub_request(:get, 'http://sushi.com/recipes/recent').to_return_json(data: [{ id: 1, title: 'Bread' }])
      assert_equal %w{ Bread }, Recipe.recent.map(&:title)
      assert_requested endpoint
    end

    def test_custom_put_request_from_class
      endpoint = stub_request(:put, 'http://sushi.com/recipes/1/publish')
      Recipe.put('/recipes/1/publish')
      assert_requested endpoint
    end

    def test_custom_put_request_from_instance
      endpoint = stub_request(:put, 'http://sushi.com/recipes/1/publish')
      Recipe.new(id: 1).publish!
      assert_requested endpoint
    end
  end
end
