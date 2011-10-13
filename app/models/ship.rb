class Ship < ActiveRecord::Base
  
  include ApplicationHelper
  
  DIRECTIONS = ['S', 'E']
  
  belongs_to :player
  
  validates_presence_of :home, :vector, :length
  validates_length_of :home, :within => 2..3
  validates_numericality_of :length, :greater_than_or_equal_to => 2, :less_than_or_equal_to => 6
  validates_inclusion_of :vector, :in => DIRECTIONS, :allow_nil => false
  
  validates_uniqueness_of :home, :scope => :player_id
  validates_uniqueness_of :length, :scope => :player_id
  
  attr_readonly :home, :vector, :length
  
  before_save :is_validly_placed?
  
  def is_validly_placed?
      cells ? true: false rescue false #Catches bad placement
  end
  
  def cells
    used_cells = []
    col, row = cell_split(home)
    length.times.each do |i|
      case vector
        when 'E'
          col.succ! unless i == 0
        when 'S'
          row = row.next unless i == 0
      end
      new_cell = "#{col}#{row}"
      if !is_a_valid_cell?(new_cell)
        raise "InvalidShipPlacement"
      end 
      used_cells << new_cell
    end
    used_cells
  end
  
end
