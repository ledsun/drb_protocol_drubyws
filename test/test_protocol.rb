# frozen_string_literal: true

require "async"

class TestProtocol < Minitest::Test
  def test_open
    Async do |task|
      uri = nil

      task.async do
        server = DRbWebSocket::Protocol.open_server("drubyws://localhost:0", {})
        uri = server.uri
        server.accept
      end

      task.async do
        connection = DRbWebSocket::Protocol.open(uri, {})

        assert_instance_of DRbWebSocket::ConnectionToServer, connection
      ensure
        connection&.close
      end
    end
  end

  def test_open_server
    assert_instance_of DRbWebSocket::Server, DRbWebSocket::Protocol.open_server("drubyws://localhost:8080", {})
  end

  def test_uri_option
    assert_equal ["ws://localhost:8080", nil], DRbWebSocket::Protocol.uri_option("ws://localhost:8080", {})
  end
end
