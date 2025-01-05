# frozen_string_literal: true

require "drb/drb"

module DRbWebSocket
  # A protocol instance from DrbWebSocket::Protocol.open.
  class ClientSocket
    def initialize(uri, socket, config = {})
      @uri = uri
      @socket = socket
      @config = config
      @msg = DRb::DRbMessage.new(config)
    end

    # Send a request to +ref+ with the given message id and arguments.
    def send_request(ref, msg_id, arg, block)
      @msg.send_request(@socket, ref, msg_id, arg, block)
    end
  end
end
