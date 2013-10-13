require 'redis'
require_relative 'users'
require_relative 'user_service'

module Roar
  module Factory
    extend self

    def user_service
      UserService.new(users)
    end

    def users
      Users.new
    end

    def redis_users
      RedisUsers.new(Redis.new)
    end
  end
end
