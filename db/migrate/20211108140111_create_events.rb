class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.datetime :start_date
      t.integer :duration
      t.string :location
      t.integer :price
      t.references :admin, index: true #Comme la table admins n'existe pas, tu ne mets pas foreign_key : true comme il est d'usage avec un t.references > La table events a donc une colonne admin_id

      t.timestamps
    end
  end
end
