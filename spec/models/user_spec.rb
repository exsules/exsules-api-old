require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'associations' do
    it { should have_one :profile }
  end

  describe 'validation' do
    let(:user) { Fabricate(:user) }

    describe 'of username' do
      it 'requires presence' do
        user.username = nil
        expect(user.save).to be false
      end

      it 'requires uniqueness' do
        user2 = Fabricate.build(:user)
        user2.save
        user.username = user2.username
        expect(user).not_to be_valid
      end

      it 'downcases username' do
        user = Fabricate.build(:user, username: 'UserNameWEseE')
        user.save
        expect(user.username_lower).to eq('usernamewesee')
      end

      it 'strips whitespaces' do
        user = Fabricate.build(:user, username: '     myusername    ')
        user.save
        expect(user.username).to eq('myusername')
      end

      it 'downcases username_lower' do
        user = Fabricate.build(:user, username: '   MyUSERNAME     ')
        user.save
        expect(user.username_lower).to eq('myusername')
      end

      it 'should be atleast 3 chars' do
        user = Fabricate(:user)
        user.username = 'aa'
        expect(user.save).to be false
      end

      it 'can be 30 characters long' do
        user.username = 'a' * 30
        expect(user).to be_valid
      end

      it 'can not be 31 characters long' do
        user.username = 'a' * 31
        expect(user).to be_invalid
      end

      ['Bad Name', 'Other%Bad', 'With!', '@handle', 'sh', 'dontwork$', 'user.name', 'blubbs;'].each do |bad_username|
        it "should now allow '#{bad_username}'" do
          user = Fabricate.build(:user)
          user.username = bad_username
          expect(user).not_to be_valid
        end
      end

      ['hostname', 'postmaster', 'admin', 'root', 'webmaster', 'sslmaster', 'bot'].each do |username|
        it "cannot be the blacklisted username '#{username}'" do
          user = Fabricate.build(:user)
          user.username = username
          expect(user).not_to be_valid
        end
      end
    end

    describe 'of email' do
      it 'requres email address' do
        user.email = nil
        expect(user).not_to be_valid
      end

      it 'requires a unique email address' do
        user2 = Fabricate(:user)
        user.email = user2.email
        expect(user.save).to be false
      end

      it 'requires a valid email address' do
        user.email = "email@email"
        expect(user).to be_invalid
      end

      it 'rejects mail@mail@example.com' do
        user.email = 'mail@mail@example.com'
        expect(user).to be_invalid
      end

      it 'downcases email' do
        user = Fabricate(:user, email: 'MAIL@ExaMPLE.com')
        user.save
        expect(user.email).to eq('mail@example.com')
      end

      it 'strips whitespaces' do
        user = Fabricate(:user, email: '   mail@example.com     ')
        user.save
        expect(user.email).to eq('mail@example.com')
      end
    end

    describe 'of language' do
      after do
        I18n.locale = :en
      end

      it 'requires valid language' do
        user.language = 'invalid language'
        expect(user).to be_invalid
      end

      it 'should save current language if blank' do
        I18n.locale = :sv
        user = Fabricate(:user, language: nil)
        user.save
        expect(user.language).to eq('sv')
      end

      it 'should save when language is set' do
        I18n.locale = :sv
        user = Fabricate(:user, language: 'no')
        user.save
        expect(user.language).to eq('no')
      end
    end
  end

end
