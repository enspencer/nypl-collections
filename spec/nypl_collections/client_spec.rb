require 'spec_helper'
require 'pry'

describe Collections::Client do
  before do
    @client = Collections::Client.new
    @client.configure do |config|
      config.auth_token = "abc123"
    end
  end

  describe '#return_captures_for_uuid' do
    before do
      stub_request(:get, "http://api.repo.nypl.org/api/v1/items/5fa75050-c6c7-012f-e24b-58d385a7bc34?withTitles=yes").to_return(body: fixture('return_captures_for_uuid.json'))
    end

    it "fetches the first ten results" do
      results = @client.return_captures_for_uuid('withTitles')
      results = JSON.parse(results.body)
      expect(a_request(:get, "http://api.repo.nypl.org/api/v1/items/5fa75050-c6c7-012f-e24b-58d385a7bc34?withTitles=yes")).to have_been_made
      expect(results.first[1].first[1].first[1]).to eq "5fa75050-c6c7-012f-e24b-58d385a7bc34"
    end
  end

end