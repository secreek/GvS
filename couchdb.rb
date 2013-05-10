# Wrapper for CouchDB
require './network.rb'

class CouchDB
  include NetworkUtils

  attr_accessor :db_endpoint;

  def initialize endpoint
    @db_endpoint = endpoint
  end

  def all_dbs
    GET_obj compose_path ["_all_dbs"]
  end

  def create_db db_name
    PUT compose_path [db_name]
  end

  def get_document db_name, doc_name
    GET_obj compose_path [db_name, doc_name]
  end

  def put_document db_name, doc_name, doc
    PUT compose_path([db_name, doc_name]), doc.to_json
  end

  def delete_document db_name, doc_name
    DELETE compose_path db_name, doc_name
  end

  private
  def compose_path segments
    path = segments.join '/'
    "#{@db_endpoint}/#{path}"
  end

end
