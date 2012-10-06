class CreateSampleObjects < ActiveRecord::Migration
  def change
    create_table :sample_objects do |t|
      t.string :type
      t.string :prefix
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :suffix
      t.timestamps
    end
  end
end
