class CreateDatabases < ActiveRecord::Migration[5.1]
  def change
    create_table :databases do |t|
      t.string :uid
      t.string :text

      t.timestamps
    end
  end
end
