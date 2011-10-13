class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :player
      t.text :message
      t.integer :priority, :default => 1
      t.timestamps
    end
  end
end
