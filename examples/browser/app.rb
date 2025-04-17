# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("lib", __dir__)
require "drb_web_socket"

module DRb
  # Patch DRb::DRbConn to use a HashStore for the connection pool
  class DRbConn
    # This is a simple HashStore that uses a hash to store the keys.
    class HashStore
      def initialize
        @pool = {}
      end

      def take(key)
        key if @pool[key]
      end

      def store(key)
        @pool[key] = true
      end
    end

    def self.make_pool
      HashStore.new
    end
  end
end

foo = DRbObject.new_with_uri("drubyws://localhost:12345")
foo.greeting
