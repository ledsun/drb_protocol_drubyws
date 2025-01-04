# frozen_string_literal: true

require_relative "drb_web_socket/version"

module DrbWebSocket
  module Protocol
    class << self
      def open(uri, config)
        Client.new
      end

      def open_server(uri, config)
        Server.new
      end

      def uri_option(uri, config)
        [uri, config]
      end
    end
  end

  class Client
  end

  class Server
  end
end
