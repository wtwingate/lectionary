class Passage < ApplicationRecord
  belongs_to :lesson

  validates :reference, presence: true
  validates :esv_text, presence: true
  validates :esv_html, presence: true

  before_validation :fetch_text_html

  private

  def fetch_text_html
    esv = Esv.new(reference)

    self.esv_text = esv.fetch_text
    self.esv_html = esv.fetch_html
  end
end
