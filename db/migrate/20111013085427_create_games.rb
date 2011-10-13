class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name
      t.string :uuid
      t.boolean :started
      t.timestamps
    end
  end
end
