class Player < ActiveRecord::Base

  after_initialize :setup_player

  has_and_belongs_to_many :games
  has_many :messages
  has_many :ships

  def game
    # If no current_game set, return the last association
    current_game.nil? ? games.last : Game.find(current_game)
  end

  def is_admin?
    game.admin == self
  end

  def is_able_to_fire?
  end

  def is_ready?
    ships.count == 4
  end

  def is_playing?
  end

  def shoot(cell)
  end

  def occupied_cells
    c = []
    ships.each { |s| c << s.cells }
    c.flatten!
  end
  
  def used_ships
    u = []
    ships.each { |s| u << s.length }
    u
  end
  
  def occupied_cells_as_js
    occupied_cells.to_json.html_safe
  end
  
  def lost_cells
    ["A2"]
  end

  def setup_player
    self.uuid ||= rand(36**8).to_s(36)
  end

end
