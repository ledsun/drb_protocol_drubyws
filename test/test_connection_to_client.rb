# frozen_string_literal: true

require "stringio"

class TestConnectionToClient < Minitest::Test
  def test_initialize
    assert_instance_of DRbWebSocket::ConnectionToClient,
                       DRbWebSocket::ConnectionToClient.new("ws://localhost:8080", nil, {})
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def test_recv_request
    # Setup a DRb server
    array = [1, 2, 3]
    drb_server = DRb.start_service("druby://localhost:0", array)

    # Setup a ClientSocket
    buffer = StringIO.new(+"", "r+")
    conn2server = DRbWebSocket::ConnectionToServer.new("ws://localhost:8080", buffer, drb_server.config)
    drb_object = DRbObject.new_with_uri(drb_server.uri)
    conn2server.send_request(drb_object, :message, [123, "abc"], -> {})

    # Receive the request
    buffer.rewind
    conn2client = DRbWebSocket::ConnectionToClient.new("ws://localhost:8080", buffer, drb_server.config)
    received_object, meg_id, args, block = conn2client.recv_request

    assert_instance_of Array, received_object
    assert_equal [1, 2, 3], received_object
    assert_instance_of String, meg_id
    assert_equal "message", meg_id
    assert_equal [123, "abc"], args
    assert_instance_of Proc, block
  ensure
    buffer&.close
    drb_server&.stop_service
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def test_close
    socket = Minitest::Mock.new
    socket.expect(:close, nil)

    conn2client = DRbWebSocket::ConnectionToClient.new("ws://localhost:8080", socket, {})
    conn2client.close

    assert_nil conn2client.instance_variable_get :@socket
  end
end
