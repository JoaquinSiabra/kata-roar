require_relative '../../lib/roar/factory'
require_relative '../../lib/roar/user'

describe 'Users in Redis', integration: true do
  users = Roar::Factory.redis_users

  before { users.clear }
  after { users.clear }

  context 'when the user exists' do
    user = Roar::User.new(A_HANDLE)
    before { users.put(user) }

    it 'returns the user' do
      expect(users.find_by_handle(A_HANDLE)).to eq user
    end
  end

  context 'when the user does not exists' do
    it 'returns nothing' do
      expect(users.find_by_handle(A_HANDLE)).to be_nil
    end
  end
end
