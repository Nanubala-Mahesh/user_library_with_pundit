class CreateLibraries < ActiveRecord::Migration
  def change
    create_table :libraries do |t|
      t.string :name
      t.text :description
      t.integer :created_by
      t.string :ref_id

      t.timestamps null: false
    end
  end
end
