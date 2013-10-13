module Roar
  class Users
    def initialize
      @users = {}
    end

    def put(user)
      @users[user.handle] = user
    end

    def find_by_handle(handle)
      @users[handle]
    end

    def clear
      @users.clear
    end
  end

  class RedisUsers
    KEY = 'users'

    def initialize(redis_driver)
      @redis_driver = redis_driver
    end

    def put(user)
      @redis_driver.hset(KEY, user.handle, Marshal.dump(user))
    end

    def find_by_handle(handle)
      user = @redis_driver.hget(KEY, handle)
      Marshal.load(user) if user
    end

    def clear
      @redis_driver.del(KEY)
    end
  end
end
