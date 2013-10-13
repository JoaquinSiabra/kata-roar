describe 'Showing the users followed by a user' do
  let(:user_service) { Roar::Factory.user_service }

  context 'when the user exists' do
    before do
      user_service.sign_up(A_HANDLE)
      user_service.sign_up(OTHER_HANDLE)
    end

    context 'when the user has followed other users' do
      before { user_service.follow(A_HANDLE, OTHER_HANDLE) }

      it 'returns the followed users' do
        followed_user = user_service.user_by_handle(OTHER_HANDLE)
        followed_users = user_service.followed_users_by(A_HANDLE)
        expect(followed_users).to include(followed_user)
      end
    end

    context 'when the user has not followed other users' do
      it 'returns an empty result' do
        followed_users = user_service.followed_users_by(A_HANDLE)
        expect(followed_users).to be_empty
      end
    end
  end

  context 'when the user does not exist' do
    it 'returns an error' do
      expect {
        user_service.followed_users_by(A_HANDLE)
      }.to raise_error Roar::Errors::UserNotFound
    end
  end
end
