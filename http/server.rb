require 'json'
require 'sinatra'
require 'sinatra/json'
require_relative '../core/lib/roar/factory'
require_relative '../core/lib/roar/errors'


user_service = Roar::Factory.user_service

post '/users', :provides => :json do
  begin
    user_service.sign_up(body_from_json['handle'])
    status 204
  rescue Roar::Errors::HandleTaken
    status 409
    json error: 'Sorry that handle is already taken.'
  end
end

post '/users/:following/followings', :provides => :json do
  begin
    user_service.follow(params[:following], body_from_json['followed'])
    status 204
  rescue Roar::Errors::UserNotFound => error
    user_not_found(error)
  end
end

get '/users/:handle/followings', :provides => :json do
  begin
    followings = user_service.followed_users_by(params[:handle])
    json(followings.map(&:handle))
  rescue Roar::Errors::UserNotFound => error
    user_not_found(error)
  end
end

def body_from_json
  JSON.parse(request.body.read)
end

def user_not_found(error)
  status 404
  json error: "User #{error} not found."
end
