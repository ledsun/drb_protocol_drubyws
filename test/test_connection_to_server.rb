# frozen_string_literal: true

require "stringio"

class TestConnectionToServer < Minitest::Test
  def test_initialize
    assert_instance_of DRbWebSocket::ConnectionToServer,
                       DRbWebSocket::ConnectionToServer.new("ws://localhost:8080", nil, {})
  end

  # rubocop:disable Metrics/MethodLength
  def test_recv_reply
    # Setup a DRb server
    array = [1, 2, 3]
    drb_server = DRb.start_service("druby://localhost:0", array)

    # Setup a ServerSocket
    buffer = StringIO.new(+"", "r+")
    conn2client = DRbWebSocket::ConnectionToClient.new("ws://localhost:8080", buffer, drb_server.config)
    conn2client.send_reply(true, [123, "abc"])

    # Receive the reply
    buffer.rewind
    conn2server = DRbWebSocket::ConnectionToServer.new("ws://localhost:8080", buffer, drb_server.config)
    succ, reply_value = conn2server.recv_reply

    assert succ
    assert_equal [123, "abc"], reply_value
  ensure
    buffer&.close
    drb_server&.stop_service
  end
  # rubocop:enable Metrics/MethodLength

  def test_close
    socket = Minitest::Mock.new
    socket.expect(:close, nil)

    conn2server = DRbWebSocket::ConnectionToServer.new("ws://localhost:8080", socket, {})
    conn2server.close

    assert_nil conn2server.instance_variable_get(:@socket)
  end

  def test_alive?
    conn2server = DRbWebSocket::ConnectionToServer.new("ws://localhost:8080", nil, {})

    refute_predicate conn2server, :alive?
  end
end
