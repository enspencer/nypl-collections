require 'json'
require 'httparty'
require 'nypl_collections/configuration'
require 'pry'
require 'dotenv'
Dotenv.load "../.env"

module Collections
  class Client
    include Collections::Configuration
    include HTTParty

    BASE_URL = "http://api.repo.nypl.org/api/v1/items/"
    BASE_URL

    def initialize
      reset
    end

    def set_urlparam(url, name, options)
      return unless options[name]
      url << "&#{name.to_s}=#{options[name]}"
    end

    def return_captures_for_uuid(uuid, options= {})
      url = BASE_URL.clone
      token = auth_token
      uuid = uuid

      url << uuid + "?"

      if options[:withTitles]
        title = options[:withTitles]
        url << "withTitles=#{title}"
      end

      [:per_page, :page].each do |thing|
        set_urlparam(url, thing, options)
      end

      HTTParty.get(url,
        :headers => {
          "Authorization" => "Token token=#{token}"
        })
    end

    def return_uuid_for_local_identifier
    end

    def search_in_mods_field
    end

    def search_all_mods_fields
    end

    def return_mods_record_for_capture_uuid
    end

  end
end



# @client = Collections::Client.new
# @client.configure do |config|
#   config.auth_token = ENV['AUTH_TOKEN']
# end

# puts @client.return_captures_for_uuid('5fa75050-c6c7-012f-e24b-58d385a7bc34', withTitles: 'yes')
# binding.pry