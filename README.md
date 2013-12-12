[![Build Status](https://travis-ci.org/enspencer/nypl-collections.png?branch=master)](https://travis-ci.org/enspencer/nypl-collections)[![Coverage Status](https://coveralls.io/repos/enspencer/nypl-collections/badge.png)](https://coveralls.io/r/enspencer/nypl-collections)

# nypl-collections

This will be a Ruby gem for the [New York Public Library Digital Collections API](http://api.repo.nypl.org/). Just got started on December 4, 2013, so check back for when it's usable, or contribute to make it happen!

## Setting Up

Sign up for an [API key](http://api.repo.nypl.org/) to start.

Setup a new instance:

```ruby
@client = Collections::Client.new
@client.configure do |config|
  config.auth_token = YOUR_AUTH_TOKEN
end
```

## Methods

### return_captures_for_uuid(uuid, options= {})
Takes a UUID for any bibliographic level, including container (a/k/a parent), collection or item-level records. Takes optional parameters of withTitles, per_page, and page.

Returns all captures for a parent-level UUID or a item-level UUID, and display the uuid, imageID, itemLink and title (optional) for each capture.

Example:

```ruby
@client.return_captures_for_uuid('5fa75050-c6c7-012f-e24b-58d385a7bc34', per_page: '10', page: '2')
```

returns:
```json
{"nyplAPI"=>
  {"request"=>
    {"uuid"=>"5fa75050-c6c7-012f-e24b-58d385a7bc34",
     "perPage"=>"10",
     "page"=>"2",
     "totalPages"=>"13",
     "startTime"=>"Beginning of Time",
     "endTime"=>"Till Now"},
   "response"=>
    {"headers"=>{"status"=>"success", "code"=>"200", "message"=>"ok"},
     "numResults"=>"125",
     "capture"=>
      [{"uuid"=>"510d47e3-6c44-a3d9-e040-e00a18064a99",
        "typeOfResource"=>"still image",
        "imageID"=>"1582671",
        "sortString"=>"0000000001|0000000011|0000000001",
        "itemLink"=>"http://digitalgallery.nypl.org/nypldigital/id?1582671",
        "dateDigitized"=>"2012-08-16T00:34:10Z"},
       {"uuid"=>"510d47e3-6c45-a3d9-e040-e00a18064a99",
        "typeOfResource"=>"still image",
        "imageID"=>"1582672",
        "sortString"=>"0000000001|0000000012|0000000001",
        "itemLink"=>"http://digitalgallery.nypl.org/nypldigital/id?1582672",
        "dateDigitized"=>"2012-08-16T00:34:10Z"},
       {"uuid"=>"510d47e3-6c46-a3d9-e040-e00a18064a99",
        "typeOfResource"=>"still image",
        "imageID"=>"1582673",
        "sortString"=>"0000000001|0000000013|0000000001",
        "itemLink"=>"http://digitalgallery.nypl.org/nypldigital/id?1582673",
        "dateDigitized"=>"2012-08-16T00:34:11Z"},
       {"uuid"=>"510d47e3-6c47-a3d9-e040-e00a18064a99",
        "typeOfResource"=>"still image",
        "imageID"=>"1582674",
        "sortString"=>"0000000001|0000000014|0000000001",
        "itemLink"=>"http://digitalgallery.nypl.org/nypldigital/id?1582674",
        "dateDigitized"=>"2012-08-16T00:34:11Z"},
       {"uuid"=>"510d47e3-6c48-a3d9-e040-e00a18064a99",
        "typeOfResource"=>"still image",
        "imageID"=>"1582675",
        "sortString"=>"0000000001|0000000015|0000000001",
        "itemLink"=>"http://digitalgallery.nypl.org/nypldigital/id?1582675",
        "dateDigitized"=>"2012-08-16T00:34:11Z"},
       {"uuid"=>"510d47e3-6c49-a3d9-e040-e00a18064a99",
        "typeOfResource"=>"still image",
        "imageID"=>"1582676",
        "sortString"=>"0000000001|0000000016|0000000001",
        "itemLink"=>"http://digitalgallery.nypl.org/nypldigital/id?1582676",
        "dateDigitized"=>"2012-08-16T00:34:11Z"},
       {"uuid"=>"510d47e3-6c4a-a3d9-e040-e00a18064a99",
        "typeOfResource"=>"still image",
        "imageID"=>"1582677",
        "sortString"=>"0000000001|0000000017|0000000001",
        "itemLink"=>"http://digitalgallery.nypl.org/nypldigital/id?1582677",
        "dateDigitized"=>"2012-08-16T00:34:11Z"},
       {"uuid"=>"510d47e3-6c4b-a3d9-e040-e00a18064a99",
        "typeOfResource"=>"still image",
        "imageID"=>"1582678",
        "sortString"=>"0000000001|0000000018|0000000001",
        "itemLink"=>"http://digitalgallery.nypl.org/nypldigital/id?1582678",
        "dateDigitized"=>"2012-08-16T00:34:11Z"},
       {"uuid"=>"510d47e3-6c4c-a3d9-e040-e00a18064a99",
        "typeOfResource"=>"still image",
        "imageID"=>"1582679",
        "sortString"=>"0000000001|0000000019|0000000001",
        "itemLink"=>"http://digitalgallery.nypl.org/nypldigital/id?1582679",
        "dateDigitized"=>"2012-08-16T00:34:11Z"},
       {"uuid"=>"510d47e3-6c4d-a3d9-e040-e00a18064a99",
        "typeOfResource"=>"still image",
        "imageID"=>"1582680",
        "sortString"=>"0000000001|0000000020|0000000001",
        "itemLink"=>"http://digitalgallery.nypl.org/nypldigital/id?1582680",
        "dateDigitized"=>"2012-08-16T00:34:11Z"}]}}}
```
### return_uuid_for_local_identifier(local_id_name, local_id_value)

Takes parameters of local identifier field name and local identifier value.

Returns uuid for a local identifier.Local_identifier field names can be found in the "type" attribute of the MODS <identifier> element (e.g. <identifier type="local_[identifier-field-name]">).

What is MODS, you ask? [Here you go.](http://www.loc.gov/standards/mods/)

Also returns page, perPage, totalPages, numResults.

example: 
```ruby
@client.return_uuid_for_local_identifier('local_hades', '1017240')
```

returns:
```json
{"nyplAPI"=>
  {"request"=>
    {"uuid"=>"ecaf7d80-c55f-012f-e3c7-58d385a7bc34",
     "perPage"=>"10",
     "page"=>"1",
     "totalPages"=>"1",
     "startTime"=>"Beginning of Time",
     "endTime"=>"Till Now"},
   "response"=>
    {"headers"=>{"status"=>"success", "code"=>"200", "message"=>"ok"},
     "numResults"=>"2",
     "capture"=>
      [{"uuid"=>"510d47e2-8e15-a3d9-e040-e00a18064a99",
        "typeOfResource"=>"still image",
        "imageID"=>"836959",
        "sortString"=>"0000000001|0000001105|0000000015|0000000001",
        "itemLink"=>"http://digitalgallery.nypl.org/nypldigital/id?836959",
        "dateDigitized"=>"2013-02-28T20:39:36Z"},
       {"uuid"=>"510d47e2-8e16-a3d9-e040-e00a18064a99",
        "typeOfResource"=>"still image",
        "imageID"=>"836960",
        "sortString"=>"0000000001|0000001105|0000000015|0000000002",
        "itemLink"=>"http://digitalgallery.nypl.org/nypldigital/id?836960",
        "dateDigitized"=>"2013-02-28T20:39:36Z"}]}}}
```

### search_in_mods_field(search_terms, field)

### search_all_mods_fields(search_terms)

### return_mods_record_for_capture_uuid(uuid)

## Contributing to nypl-collections
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2013 Emma Spencer. See LICENSE.txt for
further details.

