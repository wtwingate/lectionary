class AddPsalmHtmlToPassage < ActiveRecord::Migration[7.2]
  def change
    add_column :passages, :psalm_html, :text
  end
end
