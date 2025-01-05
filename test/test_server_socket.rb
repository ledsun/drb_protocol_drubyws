# frozen_string_literal: true

require "stringio"

class TestServerSocket < Minitest::Test
  def test_initialize
    assert_instance_of DRbWebSocket::ServerSocket, DRbWebSocket::ServerSocket.new("ws://localhost:8080", nil, {})
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def test_recv_request
    # Setup a DRb server
    array = [1, 2, 3]
    drb_server = DRb.start_service("druby://localhost:8787", array)

    # Setup a ClientSocket
    buffer = StringIO.new(+"", "r+")
    client_socket = DRbWebSocket::ClientSocket.new("ws://localhost:8080", buffer, drb_server.config)
    drb_object = DRbObject.new_with_uri(drb_server.uri)
    client_socket.send_request(drb_object, :message, [123, "abc"], -> {})

    # Receive the request
    buffer.rewind
    server_socket = DRbWebSocket::ServerSocket.new("ws://localhost:8080", buffer, drb_server.config)
    received_object, meg_id, args, block = server_socket.recv_request

    assert_instance_of Array, received_object
    assert_equal [1, 2, 3], received_object
    assert_instance_of String, meg_id
    assert_equal "message", meg_id
    assert_equal [123, "abc"], args
    assert_instance_of Proc, block
  ensure
    buffer.close
    drb_server&.stop_service
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
end
