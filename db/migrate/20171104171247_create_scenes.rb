class CreateScenes < ActiveRecord::Migration[5.1]
  def change
    create_table :scenes do |t|
      t.string :title
      t.text :content
      t.references :story, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
