# frozen_string_literal: true

require "stringio"

class TestClientSocket < Minitest::Test
  def test_initialize
    assert_instance_of DRbWebSocket::ClientSocket, DRbWebSocket::ClientSocket.new("ws://localhost:8080", nil, {})
  end
end
