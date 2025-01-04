# frozen_string_literal: true

require "test_helper"

class TestDrbWebSocket < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::DrbWebSocket::VERSION
  end
end

require_relative 'test_drb_web_socket_protocol.rb'

