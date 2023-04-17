class CreatePeople < ActiveRecord::Migration[7.0]
  def change
    create_table :people do |t|
      t.string :name
      t.bigint :parent_id, index: true

      t.timestamps
    end
  end
end
