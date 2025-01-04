# frozen_string_literal: true

require "test_helper"

class TestDrbWebSocket < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::DrbWebSocket::VERSION
  end
end

class TestDrbWebSocketServer < Minitest::Test
  def test_initialize
    assert_instance_of DrbWebSocket::Server, DrbWebSocket::Server.new("ws://localhost:8080", nil, {})
  end
end
