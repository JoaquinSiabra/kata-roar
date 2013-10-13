require_relative 'errors'
require_relative 'user'

module Roar
  class UserService
    def initialize(users)
      @users = users
    end

    def sign_up(handle)
      assert_not_taken!(handle)
      add_user(make_user(handle))
    end

    def user_by_handle(handle)
      @users.find_by_handle(handle) or raise Errors::UserNotFound.new(handle)
    end

    def follow(following_handle, followed_handle)
      following_user = user_by_handle(following_handle)
      following_user.follow(user_by_handle(followed_handle))
      @users.put(following_user)
    end

    def followed_users_by(handle)
      user_by_handle(handle).following
    end

    private

    def assert_not_taken!(handle)
      raise Errors::HandleTaken if @users.find_by_handle(handle)
    end

    def make_user(handle)
      User.new(handle)
    end

    def add_user(user)
      @users.put(user)
    end
  end
end
