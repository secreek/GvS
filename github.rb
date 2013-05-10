# Wrapper for Github API
require './network'

class Github
  extend NetworkUtils

  def self.prepare_gh_key_pair
    params = {
      "client_id" => ENV["GH_KEY_PAIR_ID"],
      "client_secret" => ENV["GH_KEY_PAIR_SECRET"]
    }

    params
  end

  # TODO test since?
  def self.activities_for_org org_name, last_hash
    headers = { "If-None-Match" => last_hash }
    url = "https://api.github.com/orgs/#{org_name}/events"
    page_count = 10
    params = prepare_gh_key_pair
    activities, etag = GET_obj_with_etag(url, params, headers) # grab first pages

    return [nil, etag] unless activities

    (2..page_count).each do |idx|
      params["page"] = idx
      activities += GET_obj(url, params, headers) # concat the pages
    end

    [activities, etag]
  end
end
