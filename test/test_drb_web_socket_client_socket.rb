# frozen_string_literal: true

require "stringio"

class TestDrbWebSocketClientSocket < Minitest::Test
  def test_initialize
    assert_instance_of DrbWebSocket::ClientSocket, DrbWebSocket::ClientSocket.new("ws://localhost:8080", nil, {})
  end
end
