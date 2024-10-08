class Passage < ApplicationRecord
  belongs_to :lesson

  validates :reference, presence: true

  def fetch_missing_data
    if reference.starts_with?("Psalm")
      fetch_psalm unless psalm_text && psalm_html
    else
      fetch_esv unless esv_text && esv_html
    end
    self.save
  end

  def get_text
    reference.starts_with?("Psalm") ? psalm_text : esv_text
  end

  def get_html
    reference.starts_with?("Psalm") ? psalm_html : esv_html
  end

  private

  def fetch_esv
    esv = Esv.new(reference)

    self.esv_text = esv.fetch_text
    self.esv_html = "<h2>#{reference}</h2>" + esv.fetch_html
  end

  def fetch_psalm
    if reference.starts_with?("Psalm")
      number = reference.delete_prefix("Psalm ").split(":")[0]
      psalm = Psalm.find_by(number: number)
      self.psalm_text = psalm.get_text(reference)
      self.psalm_html = "<h2>#{reference}</h2>" + psalm.get_html(reference)
    end
  end
end
