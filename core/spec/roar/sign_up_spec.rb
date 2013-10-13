describe 'Signing up a user' do
  let(:user_service) { Roar::Factory.user_service }

  context 'when the handle is not taken' do
    it 'the user successfuly signs up' do
      user_service.sign_up(A_HANDLE)
      signed_up_user = user_service.user_by_handle(A_HANDLE)
      expect(signed_up_user.handle).to eq A_HANDLE
    end
  end

  context 'when the handle is taken' do
    before { user_service.sign_up(A_HANDLE) }

    it 'returns an error' do
      expect {
        user_service.sign_up(A_HANDLE)
      }.to raise_error Roar::Errors::HandleTaken
    end
  end
end
