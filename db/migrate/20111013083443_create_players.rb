class CreatePlayers < ActiveRecord::Migration
  def change
    create_table(:players) do |t|
      t.string :name
      t.string :uuid
      t.integer :current_game
      t.timestamps
    end
  end
end
