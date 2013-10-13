module Roar
  module Errors
    HandleTaken  = Class.new(RuntimeError)
    UserNotFound = Class.new(RuntimeError)
  end
end
