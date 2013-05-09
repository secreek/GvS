# Syncronzie github events to local NoSQL Database
require 'json'

class GvS
  attr_accessor :config

  def initialize
    @config = JSON.load(open('config.json').read)
  end

  def serve
    # make sure the database exits
    db_name = @config["db-name"]
    create_db db_name unless db_exist? db_name
    # start a daemon that GET the latest event every @config["sync-period"] seconds
    a_while = @config["sync-period"]
    while true do
      insert new_event_since last_event
      sleep a_while
    end
  end

  # private util functions
  private
  def db_exist? db_name
    return false
  end

  def create_db db_name
  end

  def insert data
    # insert data into CouchDB
  end

  def last_event
    # grab last event's hash code
  end

  def new_event_since last_hash
    # grab new event from github api
  end

end

app = GvS.new
app.serve
