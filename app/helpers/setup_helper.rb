module SetupHelper

	HORIZ_RANGE = 'A'..'J'
	VERT_RANGE = 1..10
	SHIP_NAMES = {"Aircraft Carrier" => 5,
			"Battleship" => 4,
			"Destroyer" => 3,
			"Submarine" => 2}

  def ship_picker(used)
    list = ''
    SHIP_NAMES.invert.sort{|a,b|b<=>a}.each do |s,n|
      list << "<li><label id='ship-#{s}'><input type='radio' name='shipclass' value='#{s}'"
      list << (used.member?(s) ? " disabled><a class='close' data-length='#{s}'>x</a>" : ">")
      list << " <span>#{n} (#{s})</span></label></li>"
    end
    list << "<li style='display:none'><input type='radio' name='shipclass' value='0' /></li>"
    list.html_safe
  end

  def grid_picker(from)
    grid = table_header
    occupied = from.occupied_cells
    occupied ||= [0]
    others = from.lost_cells
    others ||= [0]
    VERT_RANGE.to_a.each do |c|
      grid << table_row(c, occupied, others)
    end
    grid.html_safe
  end

  def table_header
    head = '<thead><tr><th></th>'
    HORIZ_RANGE.to_a.each { |l| 	head << "<th>#{l}</th>" }
    head << '</tr></thead>'
  end

  def table_row(c, occupied, others)
    row = "<tr><td>#{c}</td>"
    HORIZ_RANGE.to_a.each do |l|
      cell = "#{l}#{c}"
      row << "<td class='"
      row << (occupied.member?(cell) ? "occupied" : "available")
      row << (others.member?(cell) ? " hit" : " miss")
      row << "' data-col='#{l}' data-row='#{c}'"
      row << " id='#{cell}'></td>"
    end
    row << '</tr>'
  end

end
