# frozen_string_literal: true

class TestProtocol < Minitest::Test
  def test_open
    assert_instance_of DRbWebSocket::ConnectionToServer, DRbWebSocket::Protocol.open("ws://localhost:8080", {})
  end

  def test_open_server
    assert_instance_of DRbWebSocket::Server, DRbWebSocket::Protocol.open_server("ws://localhost:8080", {})
  end

  def test_uri_option
    assert_equal ["ws://localhost:8080", {}], DRbWebSocket::Protocol.uri_option("ws://localhost:8080", {})
  end
end
