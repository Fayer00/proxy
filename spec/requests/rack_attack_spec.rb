# spec/requests/rack_attack_spec.rb
require "rails_helper"
RSpec.describe "Rack::Attack", type: :request do
  # Include time helpers to allow use to use travel_to
  # within RSpec
  include ActiveSupport::Testing::TimeHelpers
  before do
    # Enable Rack::Attack for this test
    Rack::Attack.enabled = true
    Rack::Attack.reset!
  end
  before(:each) do
    setup_rack_attack_cache_store
    avoid_test_overlaps_in_cache
  end

  def setup_rack_attack_cache_store
    Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new
  end

  def avoid_test_overlaps_in_cache
    Rails.cache.clear
  end
  after do
    # Disable Rack::Attack for future tests so it doesn't
    # interfere with the rest of our tests
    Rack::Attack.enabled = false
  end
  describe "GET /proxy/url" do
    let(:valid_params) { {url_type:'categories', url_id: 'MLA23455'} }
    let(:valid_params2) { {url_type:'filters', url_id: 'MLA23455'} }
    # Set the headers, if you'd blocking specific IPs you can change
    # this programmatically.
    let(:headers) { {"REMOTE_ADDR" => "1.2.3.4"} }
    it "successful for 10 requests, then blocks the user nicely" do
      10.times do
        get "/#{valid_params[:url_type]}/#{valid_params[:url_id]}", headers: headers

        expect(response).to have_http_status(:success)
      end
      get "/#{valid_params[:url_type]}/#{valid_params[:url_id]}", headers: headers
      expect(response.body).to include("Retry later")
      expect(response).to have_http_status(:too_many_requests)
      travel_to(10.minutes.from_now) do
        get "/#{valid_params[:url_type]}/#{valid_params[:url_id]}", headers: headers
        expect(response).to have_http_status(:success)
      end
    end
  end
end