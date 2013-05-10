# Syncronzie github events to local NoSQL Database
require 'json'

require './couchdb'
require './github'

class GvS
  attr_accessor :config
  attr_accessor :couch

  def initialize
    @config = JSON.load(open('config.json').read)
    @couch = CouchDB.new @config["couchdb-endpoint"]
  end

  def serve
    # make sure the database exits
    db_name = @config["db-name"]
    create_db_if_not_exist db_name

    # start a daemon that GET the latest event every @config["sync-period"] seconds
    a_while = @config["sync-period"]
    while true do
      insert new_event_since last_event
      sleep a_while
    end
  end

  # private util functions
  private
  def create_db_if_not_exist db_name
    if !db_exist? db_name
      create_db db_name
      # since the initial data maybe very large,
      # we'll process them for now
      insert new_event_since # the beginning
    end
  end

  def db_exist? db_name
    @couch.all_dbs.include? db_name
  end

  def create_db db_name
    @couch.create_db db_name
  end

  def insert combined_data
    data, etag = combined_data
    # make sure the data exists
    return unless data && data.length > 0

    # insert data into CouchDB
    db_name = @config["db-name"]
    data.each do |event|
      date_time = event["created_at"] # use date as doc name
      doc_name = date_time[0, date_time.index("T")] # strips the time part
      doc = @couch.get_document db_name, doc_name
      if doc
        (doc["data"].include? event) ? break : doc["data"] << event
      else # if doc does not exists, create the doc
        doc = { "data"  => [event] }
      end

      @couch.put_document db_name, doc_name, doc
    end

    # update last event for next grab
    update_last_event etag
  end

  def last_event
    # grab last event's hash code
    doc = @couch.get_document @config["db-name"], "last"
    doc["etag"] if doc
  end

  def update_last_event etag
    db_name = @config["db-name"]
    doc = @couch.get_document db_name, "last"
    doc ||= {}
    doc["etag"] = etag
    @couch.put_document db_name, "last", doc
  end

  def new_event_since last_hash = nil
    # grab new event from github api
    Github.activities_for_org @config["org-name"], last_hash
  end

end
