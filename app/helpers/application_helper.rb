module ApplicationHelper

  HORIZ_RANGE = 'A'..'J'
  VERT_RANGE = 1..10
  SHIP_NAMES = {"Aircraft Carrier" => 5,
                               "Battleship" => 4,
                              "Destroyer" => 3,
                              "Submarine" => 2}

	def is_a_valid_cell?(cell)
		col, row = cell_split(cell)
		true if HORIZ_RANGE.member?(col) and VERT_RANGE.member?(row)
	end
	
	def cell_split(cell)
		col = cell.match(/[A-Z]+/).to_s
		row = cell.match(/[0-9]+/).to_s.to_i
		return col, row
	end

  ### AUTH ###

  def current_player
    p = Player.find_by_uuid(session[:player]) unless !logged_in?
    if p.nil?
      reset_session
    end
    p
  end

  def current_game
    current_player.game
  end

  def logged_in?
    session[:player].nil? ? false : true
  end

end
