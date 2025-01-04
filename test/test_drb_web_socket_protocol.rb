# frozen_string_literal: true

class TestDrbWebSocketProtocol < Minitest::Test
  def test_open
    assert_instance_of DrbWebSocket::Socket, DrbWebSocket::Protocol.open("ws://localhost:8080", {})
  end

  def test_open_server
    assert_instance_of DrbWebSocket::Server, DrbWebSocket::Protocol.open_server("ws://localhost:8080", {})
  end

  def test_uri_option
    assert_equal ["ws://localhost:8080", {}], DrbWebSocket::Protocol.uri_option("ws://localhost:8080", {})
  end
end
