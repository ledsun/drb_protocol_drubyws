$LOAD_PATH.unshift File.expand_path('lib', __dir__)
require "drb_web_socket"

class DRb::DRbConn
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

foo = DRbObject.new_with_uri("drubyws://localhost:12345")
foo.greeting
