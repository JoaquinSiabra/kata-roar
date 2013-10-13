require_relative '../core/lib/roar/factory'

user_service = Roar::Factory.user_service

ACTIONS = {
  'signup'  => lambda { |handle| user_service.sign_up(handle) },
  'follow'  => lambda { |following, followed| user_service.follow(following, followed) },
  'followed' => lambda do |handle|
    puts user_service.following_users_by(handle).map(&:handle).join("\n")
  end,
  'exit'    => lambda { exit }
}

unknown_action = lambda do |*|
  puts "ERROR: unknown action"
  puts "VALID COMMANDS: #{ACTIONS.keys.join(', ')}"
end

begin
  print "> "
  while line = gets.chomp
    action_name, *args = line.split
    action = ACTIONS.fetch(action_name, unknown_action)
    action.call(*args)
    print "\n> "
  end
rescue Interrupt
  exit
end
