# Wrapper for Github API
require './network_utils'

class Github
  include NetworkUtils

  def self.prepare_gh_key_pair
    params = {
      "client_id" => ENV["GH_KEY_PAIR_SECRET"],
      "client_secret" => ENV["GH_KEY_PAIR_SECRET"]
    }

    params
  end

  def self.activities_for org_name, last_hash
    url = "https://api.github.com/users/#{org_name}/events"
    page_count = 10
    params = prepare_gh_key_pair
    activities = []
    page_count.times do |idx|
      params["page"] = idx + 1
      # TODO how to insert an array to another?
      activities << GET_obj(url, params)
    end
    activities
  end
end
