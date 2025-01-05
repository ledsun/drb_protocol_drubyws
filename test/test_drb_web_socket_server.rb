# frozen_string_literal: true

class TestDrbWebSocketServer < Minitest::Test
  def test_initialize
    assert_instance_of DrbWebSocket::Server, DrbWebSocket::Server.new("ws://localhost:8080", nil, {})
  end

  def test_accept
    server = DrbWebSocket::Server.new("ws://localhost:8080", nil, {})

    assert_instance_of DrbWebSocket::ServerSocket, server.accept
  end

  def test_close
    socket = Minitest::Mock.new
    socket.expect(:close, nil)

    server = DrbWebSocket::Server.new("ws://localhost:8080", socket, {})
    server.close

    assert_nil server.instance_variable_get(:@socket)
  end

  def test_uri
    server = DrbWebSocket::Server.new("ws://localhost:8080", nil, {})

    assert_equal "ws://localhost:8080", server.uri
  end
end
