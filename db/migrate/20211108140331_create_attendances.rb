class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.string :stripe_customer_id
      t.references :customer, index: true #Comme la table customers n'existe pas, tu ne mets pas foreign_key : true comme il est d'usage avec un t.references, mais index: true > La table attendances a donc une colonne customer_id
      t.belongs_to :event, index: true

      t.timestamps
    end
  end
end
