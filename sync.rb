# Syncronzie github events to local NoSQL Database
require 'json'

require './couchdb'

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
      # populate initial data
      insert new_event_since # the beginning
    end
  end

  def db_exist? db_name
    @couch.all_dbs.include? db_name
  end

  def create_db db_name
    @couch.create_db db_name
  end

  def insert data
    # make sure the data is valid
    return unless data.length > 0

    # insert data into CouchDB
    data.each do |event|
    end

    # update last event for next grab
    update_last_event data[0]
  end

  def last_event
    # grab last event's hash code
    doc = @couch.grab_document_from_db "last", @config["db-name"]
    doc["hash"]
  end

  def update_last_event event
    db_name = @config["db-name"]
    doc = @couch.get_document db_name, "last"
    doc["hash"] = event["hash"] # TODO change this
    @couch.put_document db_name, "last", doc
  end

  def new_event_since last_hash = nil
    # grab new event from github api
  end

end

app = GvS.new
app.serve
