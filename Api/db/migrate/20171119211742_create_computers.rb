class CreateComputers < ActiveRecord::Migration[5.1]
  def change
    create_table :computers do |t|
      t.integer :pointer
      t.string :stack, array: true, default: []

      t.timestamps
    end
  end
end
