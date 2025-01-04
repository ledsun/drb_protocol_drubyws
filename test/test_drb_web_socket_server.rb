# frozen_string_literal: true

class TestDrbWebSocketServer < Minitest::Test
  def test_initialize
    assert_instance_of DrbWebSocket::Server, DrbWebSocket::Server.new("ws://localhost:8080", nil, {})
  end

  def test_accept
    server = DrbWebSocket::Server.new("ws://localhost:8080", nil, {})

    assert_instance_of DrbWebSocket::ServerSocket, server.accept
  end
end
