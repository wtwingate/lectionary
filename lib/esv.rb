require "net/http"

class Esv
  def initialize(reference)
    @reference = reference
    @api_key = ENV["ESV_API_KEY"]
  end

  def fetch_html
    JSON.parse(api_query("html"))["passages"]
  end

  def fetch_text
    JSON.parse(api_query("text"))["passages"]
  end

  private

  def api_query(endpoint)
    headers = { Authorization: "Token #{@api_key}" }
    uri = URI("https://api.esv.org/v3/passage/#{endpoint}/")
    params = endpoint == "html" ? html_params : text_params
    uri.query = URI.encode_www_form(params)

    Net::HTTP.get(uri, headers)
  end

  def html_params
    # https://api.esv.org/docs/passage-html/
    {
      q: @reference,
      include_footnotes: false,
      include_headings: false,
      include_short_copyright: false,
      include_audio_link: false
    }
  end

  def text_params
    # https://api.esv.org/docs/passage-text/
    {
      q: @reference,
      include_footnotes: false,
      include_headings: false,
      include_short_copyright: false
    }
  end
end
