require "net/http"

class Esv
  def initialize(reference, endpoint = "text")
    @reference = reference
    @endpoint = endpoint
    @params = self.default_params
    @api_key = ENV["ESV_API_KEY"]
  end

  def fetch_passages
    JSON.parse(self.api_query)["passages"]
  end

  private

  def api_query
    headers = { Authorization: "Token #{@api_key}" }
    uri = URI("https://api.esv.org/v3/passage/#{@endpoint}/")
    uri.query = URI.encode_www_form(@params)

    Net::HTTP.get(uri, headers)
  end

  def default_params
    if @endpoint == "text"
      # https://api.esv.org/docs/passage-text/
      {
        q: @reference
      }
    elsif @endpoint == "html"
      # https://api.esv.org/docs/passage-html/
      {
        q: @reference,
        include_footnotes: false,
        include_headings: false,
        include_short_copyright: false,
        include_audio_link: false
      }
    else
      raise "No params defined for /#{@endpoint}/ endpoint"
    end
  end
end
