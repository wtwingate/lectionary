class AddPsalmTextToPassage < ActiveRecord::Migration[7.2]
  def change
    add_column :passages, :psalm_text, :text
  end
end
