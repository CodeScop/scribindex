class CreateCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :characters do |t|
      t.string :nym
      t.string :fullname
      t.integer :birthyear
      t.text :details
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
