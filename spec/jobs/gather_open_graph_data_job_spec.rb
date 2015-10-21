require 'rails_helper'

RSpec.describe GatherOpenGraphDataJob, type: :job do
  include ActiveJob::TestHelper
  let(:post) { Fabricate(:post) }

  before :all do
    WebMock.disable_net_connect! allow_localhost: true, allow: '127.0.0.1:*'
  end

  after :all do
    WebMock.disable_net_connect!
  end

  before do
    @ogsite_title = 'Homepage'
    @ogsite_type = 'website'
    @ogsite_image = 'http://example.com/img/image.png'
    @ogsite_url = 'http://example.com'
    @ogsite_description = 'Hompage'

    @ogsite_body =
      "<html><head><title>#{@ogsite_title}</title>
      <meta property=\"og:title\" content=\"#{@ogsite_title}\"/>
      <meta property=\"og:type\" content=\"#{@ogsite_type}\" />
      <meta property=\"og:image\" content=\"#{@ogsite_image}\" />
      <meta property=\"og:url\" content=\"#{@ogsite_url}\" />
      <meta property=\"og:description\" content=\"#{@ogsite_description}\" />
      </head><body></body></html>"

    @oglong_title = "D" * 256
    @oglong_url = 'http://www.we-are-too-long.com'
    @oglong_body =
      "<html><head><title>#{@oglong_title}</title>
      <meta property=\"og:title\" content=\"#{@oglong_title}\"/>
      <meta property=\"og:type\" content=\"#{@ogsite_type}\" />
      <meta property=\"og:image\" content=\"#{@ogsite_image}\" />
      <meta property=\"og:url\" content=\"#{@oglong_url}\" />
      <meta property=\"og:description\" content=\"#{@ogsite_description}\" />
      </head><body></body></html>"

    @no_open_graph_url = 'http://www.we-do-not-support-open-graph.com/index.html'

    stub_request(:head, @ogsite_url).to_return(status: 200, body: "", headers: {'Content-Type' => 'text/html; utf-8'})
    stub_request(:get, @ogsite_url).to_return(status: 200, body: @ogsite_body, headers: {'Content-Type' => 'text/html; utf-8'})
    stub_request(:head, @no_open_graph_url).to_return(status: 200, body: "", headers: {'Content-Type' => 'text/html; utf-8'})
    stub_request(:get, @no_open_graph_url).to_return(:status => 200, :body => '<html><head><title>Hi</title><body>hello there</body></html>', headers: {'Content-Type' => 'text/html; utf-8'})
    stub_request(:head, @oglong_url).to_return(status: 200, body: "", headers: {'Content-Type' => 'text/html; utf-8'})
    stub_request(:get, @oglong_url).to_return(status: 200, body: @oglong_body, headers: {'Content-Type' => 'text/html; utf-8'})

  end

  describe '.perform' do
    it 'requests data from internet' do
      GatherOpenGraphDataJob.perform_now(post.id, @ogsite_url)

      expect(a_request(:get, @ogsite_url)).to have_been_made
    end

    it 'reqeusts data from internet only once' do
      4.times do
        perform_enqueued_jobs { GatherOpenGraphDataJob.perform_now(post.id, @ogsite_url) }
      end

      expect(a_request(:get, @ogsite_url)).to have_been_made.times(1)
    end

    it 'creates a cache' do
      perform_enqueued_jobs { GatherOpenGraphDataJob.perform_now(post.id, @ogsite_url) }

      ogc = OpenGraphCache.find_by_url(@ogsite_url)

      expect(ogc.title).to eq(@ogsite_title)
      expect(ogc.ob_type).to eq(@ogsite_type)
      expect(ogc.image).to eq(@ogsite_image)
      expect(ogc.url).to eq(@ogsite_url)
      expect(ogc.description).to eq(@ogsite_description)

    end

    it 'creates no cache for unsupported' do
      perform_enqueued_jobs { GatherOpenGraphDataJob.perform_now(post.id, @no_open_graph_url) }

      expect(OpenGraphCache.find_by_url(@no_open_graph_url)).to be_nil
    end

    it 'handles deleted post' do
      expect {
          perform_enqueued_jobs { GatherOpenGraphDataJob.perform_now(0, @ogsite_url) }
      }.to_not raise_error
    end

    it 'truncates too long titles' do
      perform_enqueued_jobs { GatherOpenGraphDataJob.perform_now(post.id, @oglong_url) }
      ogc = OpenGraphCache.find_by_url(@oglong_url)
      expect(ogc).to be_truthy
      expect(ogc.title.length).to be <= 255
    end
  end
end
