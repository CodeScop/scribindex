class CreateGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :groups do |t|
      t.string :title
      t.text :description
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
