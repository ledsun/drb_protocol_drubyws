# frozen_string_literal: true

class TestServer < Minitest::Test
  DUMMY_SOCKET = Class.new do
    def accept = self
    def close; end
    def to_io = self
  end.new

  def test_initialize
    assert_instance_of DRbWebSocket::Server, DRbWebSocket::Server.new("ws://localhost:8080", DUMMY_SOCKET, {})
  end

  def test_accept
    server = DRbWebSocket::Server.new("ws://localhost:8080", DUMMY_SOCKET, {})

    assert_instance_of DRbWebSocket::ConnectionToClient, server.accept
  end

  def test_close
    socket = Minitest::Mock.new
    socket.expect(:close, nil)
    socket.expect(:to_io, socket)

    server = DRbWebSocket::Server.new("ws://localhost:8080", socket, {})
    server.close

    assert_nil server.instance_variable_get(:@socket)
  end

  def test_uri
    server = DRbWebSocket::Server.new("ws://localhost:8080", DUMMY_SOCKET, {})

    assert_equal "ws://localhost:8080", server.uri
  end
end
