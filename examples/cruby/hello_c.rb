# frozen_string_literal: true

require "drb_web_socket/client"

foo = DRbObject.new_with_uri("drubyws://localhost:12345")
foo.greeting
