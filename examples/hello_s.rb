# frozen_string_literal: true

require "drb_web_socket"

# This is a sample class.
class Foo
  def greeting = puts "Hello, world!"
end

DRb.start_service "drbws://localhost:12345", Foo.new
sleep
