require 'spec_helper'

describe Collections do
  describe '.new' do
    it "returns a Collections::Client" do
      expect(Collections.new).to be_a Collections::Client
    end
  end

  describe ".configure" do
    it "sets auth_token" do
      Collections.configure do |config|
        config.auth_token = "secret"
      end

      expect(Collections.auth_token).to eq "secret"
    end
  end
end