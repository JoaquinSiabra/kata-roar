describe 'Following a user' do
  let(:user_service) { Roar::Factory.user_service }

  context 'when the following and followed users exist' do
    before do
      user_service.sign_up(A_HANDLE)
      user_service.sign_up(OTHER_HANDLE)
    end

    it 'makes the following user follow the followed user' do
      user_service.follow(A_HANDLE, OTHER_HANDLE)
      following_user = user_service.user_by_handle(A_HANDLE)
      followed_users = following_user.following
      followed_handles = followed_users.map(&:handle)
      expect(followed_handles).to include(OTHER_HANDLE)
    end
  end

  context 'when the followed user does not exist' do
    before { user_service.sign_up(A_HANDLE) }

    it 'returns an error' do
      expect_error_when_following(A_HANDLE, OTHER_HANDLE)
    end
  end

  context 'when the following user does not exist' do
    before { user_service.sign_up(OTHER_HANDLE) }

    it 'returns an error' do
      expect_error_when_following(A_HANDLE, OTHER_HANDLE)
    end
  end

  def expect_error_when_following(following_handle, followed_handle)
    expect {
      user_service.follow(following_handle, followed_handle)
    }.to raise_error Roar::Errors::UserNotFound
  end
end
