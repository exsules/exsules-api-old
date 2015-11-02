require 'rails_helper'

RSpec.describe Post, type: :model do
  include ActiveJob::TestHelper

  describe 'associations' do
    it { should belong_to :profile }
    it { should belong_to :open_graph_cache }
  end

  describe 'open_graph_cache' do
    before do
      @exsules_url = "https://exsules.com"
      @post_text = "Found this cool project @ #{@exsules_url}"
    end

    pending 'should queue GatherOpenGraphDataJob if links are included' do
      post = Fabricate.build(:post, text: @post_text)
      expect(GatherOpenGraphDataJob).to receive(:perform_later).with(instance_of(Fixnum), instance_of(String))
      post.save
    end

    describe '#contains_open_graph_url_in_text?' do
      it 'returns the opengraph url' do
        post = Fabricate.build(:post, text: @post_text)
        expect(post.contains_open_graph_url_in_text?).not_to be_nil
        expect(post.open_graph_url).to eq(@exsules_url)
      end
    end
  end
end
