require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'validation' do
    describe 'of first_name' do
      it 'strips leading and trailing whitespaces' do
        profile = Fabricate.build(:profile, first_name: '    Sandra    ', user_id: 1)
        profile.save
        expect(profile.first_name).to eq('Sandra')
      end

      it 'can be 32 characters long' do
        profile = Fabricate.build(:profile, first_name: 'S'*32)
        expect(profile).to be_valid
      end

      it 'cannot be 33 characters' do
        profile = Fabricate.build(:profile, first_name: 'S'*33)
        expect(profile).to be_invalid
      end
    end

    describe 'of last_name' do
      it 'strips leading and trailing whitespaces' do
        profile = Fabricate.build(:profile, last_name: '    Eriksson    ', user_id: 1)
        profile.save
        expect(profile.last_name).to eq('Eriksson')
      end

      it 'can be 32 characters long' do
        profile = Fabricate.build(:profile, last_name: 'S'*32)
        expect(profile).to be_valid
      end

      it 'cannot be 33 characters' do
        profile = Fabricate.build(:profile, last_name: 'S'*33)
        expect(profile).to be_invalid
      end
    end

    describe 'of location' do
      it 'can be 255 characters long' do
        profile = Fabricate.build(:profile, location: "n"*255)
        expect(profile).to be_valid
      end

      it 'cannot be 256 characters' do
        profile = Fabricate.build(:profile, location: "n"*256)
        expect(profile).to be_invalid
      end
    end

  end
end
