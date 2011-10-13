class Game < ActiveRecord::Base

  after_initialize :setup_game
  
  has_and_belongs_to_many :players
  
  # Player functions
  
  def admin
    players.first
  end
  
  def setup_game
    self.uuid ||= rand(36**8).to_s(36)
  end

end
