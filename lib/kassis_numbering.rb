require "version"
require 'net/http'
require 'json'

module KassisNumbering

  DEFAULT_SERVICE_SERVER = "http://localhost:59630"
  NUMBERING_PREFIX = "/numbering/"

  def self.numbering(identifier, service_url = nil)
    service_url = service_url || DEFAULT_SERVICE_SERVER
    url = URI.parse("#{service_url}#{NUMBERING_PREFIX}#{identifier}")
    req = Net::HTTP::Get.new(url.path)
    res = Net::HTTP.start(url.host, url.port) {|http|
      http.request(req)
    }
    result = JSON.parse(res.body)
    return result['v']
  end
end
