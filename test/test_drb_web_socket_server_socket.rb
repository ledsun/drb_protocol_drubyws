# frozen_string_literal: true

class TestDrbWebSocketServerSocket < Minitest::Test
  def test_initialize
    assert_instance_of DrbWebSocket::ServerSocket, DrbWebSocket::ServerSocket.new("ws://localhost:8080", nil, {})
  end

  def test_recv_request
    socket = DrbWebSocket::ServerSocket.new("ws://localhost:8080", nil, {})

    object, message, args, block = socket.recv_request

    assert_instance_of Object, object
    assert_equal :message, message
    assert_empty args
    assert_instance_of Proc, block
  end
end
