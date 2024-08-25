require "net/http"

class Esv
  def initialize(reference)
    @reference = reference.gsub(/[\(\)]/, "")  # use the full passage
    @api_key = ENV["ESV_API_KEY"]
  end

  def fetch_text
    raw_texts = JSON.parse(api_query("text"))["passages"]
    format_raw_texts(raw_texts)
  end

  def fetch_html
    JSON.parse(api_query("html"))["passages"].join
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
      include_passage_references: false,
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
      include_passage_references: false,
      include_footnotes: false,
      include_headings: false,
      include_short_copyright: false,
      indent_using: "spaces",
      indent_paragraphs: 0,
      indent_poetry_lines: 4
    }
  end

  def format_raw_texts(raw_texts)
    raw_texts.each { |text| text.strip! }

    raw_texts.join("\n\n")            # join sub-sections of the passage
             .gsub(/[\[\]]/, "")      # remove brackets around verses
             .gsub(/^\s{4}/, "")      # remove excess padding of poetry
             .gsub("\n\n\n", "\n\n")  # remove excess blank line between paragraphs
  end
end
