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
      url << "&#{name.to_s.gsub(/ /,'_')}=#{options[name]}"
    end

# Return all capture UUIDs, imageIDs, itemLinks and
# titles (optional) for any UUID 
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

# Return uuid for a local identifier.
# Local_identifier field names can be found in the
# "type" attribute of the MODS <identifier> element
    def return_uuid_for_local_identifier(local_id_name, local_id_value)
      url = BASE_URL.clone
      token = auth_token
      local_id_name = local_id_name
      local_id_value = local_id_value

      url << "#{local_id_name}/#{local_id_value}"

      HTTParty.get(url,
        :headers => {
          "Authorization" => "Token token=#{token}"
        })

    end


# search in fields: identifier, typeOfResource, note
# title, namePart, place, publisher, topic,
# geographic, temporal, genre, physicalLocation, and shelfLocator
# enter search_terms 
    def search_in_mods_field(search_terms, field)
      # search?q=[search-terms]&field=[mods-field] 
      url = BASE_URL.clone
      token = auth_token
      search_terms = search_terms.gsub(/ /, "-").gsub(/_/, "-")
      field = field

      url << "search?q=#{search_terms}&field=#{field}"

      HTTParty.get(url,
        :headers => {
          "Authorization" => "Token token=#{token}"
        })
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
#   binding.pry
# end
binding.pry