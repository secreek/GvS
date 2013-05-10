# Wraps basic HTTP verbs, like GET, PUT
require 'json'
require 'net/http'


module NetworkUtils
  def GET url, params = {}, headers = {}
    uri = URI(url)
    uri.query = URI.encode_www_form(params)

    Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      request = Net::HTTP::Get.new uri.request_uri
      headers.each_pair do |k, v|
        request[k] = v
      end

      response = http.request request # Net::HTTPResponse object
      return response if response.is_a?(Net::HTTPSuccess)
    end

    nil
  end

  def PUT url, data = "", params = {}, headers = {}
    uri = URI(url)
    uri.query = URI.encode_www_form(params)

    Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
      request = Net::HTTP::Put.new uri.request_uri
      headers.each_pair do |k, v|
        request[k] = v
      end

      response = http.request request, data # Net::HTTPResponse object
      return response.body if response.is_a?(Net::HTTPSuccess)
    end

    nil
  end

  def GET_obj url, params = {}, headers = {}
    GET_obj_with_etag(url, params, headers)[0]
  end

  def GET_obj_with_etag url, params = {}, headers = {}
    resp = GET url, params, headers
    body = nil
    etag = nil
    if resp.is_a?(Net::HTTPSuccess)
      etag = resp["ETag"]
      body = resp.body ? JSON.load(resp.body) : nil
    end
    [body, etag]
  end

end
