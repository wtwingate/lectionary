class Passage < ApplicationRecord
  belongs_to :lesson

  validates :reference, presence: true
  validates :esv_text, presence: true
  validates :esv_html, presence: true

  before_validation :fetch_esv, :get_psalm

  private

  def fetch_esv
    esv = Esv.new(reference)

    self.esv_text = esv.fetch_text
    self.esv_html = esv.fetch_html
  end

  def get_psalm
    if reference.starts_with?("Psalm")
      number = reference.delete_prefix("Psalm ").split(":")[0]
      psalm = Psalm.find(number: number)
      self.psalm_text = psalm.get_text(reference)
      self.psalm_html = psalm.get_html(reference)
    end
  end
end
