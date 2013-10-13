require 'set'

module Roar
  class User
    attr_reader :handle, :following

    def initialize(handle)
      @handle = handle
      @following = Set.new
    end

    def follow(followed_user)
      @following.add(followed_user)
    end

    def ==(other)
      other.handle == handle
    end
  end
end
