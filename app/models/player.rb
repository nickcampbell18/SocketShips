class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  after_initialize :setup_player
  
  has_and_belongs_to_many :games
  has_many :messages
  
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
  end
  
  def is_playing?
  end
  
  def shoot(cell)
  end
  
  def place_ship(opts = {})
  end
  
  def notify_hit(cell)
  end
  
  def notify_loss(cell)
  end
  
  def notify_miss(cell)
  end
  
  def ships
  end
  
  def setup_player
    self.uuid ||= rand(36**8).to_s(36)
    self.email = "#{uuid}@none.com"
  end
  
end
