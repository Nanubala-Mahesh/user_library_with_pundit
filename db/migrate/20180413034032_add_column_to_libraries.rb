class AddColumnToLibraries < ActiveRecord::Migration
  def change
    add_column :libraries, :purchased_on, :date
    add_column :libraries, :in_possession_of, :integer
    add_column :libraries, :title, :string

  end
end
