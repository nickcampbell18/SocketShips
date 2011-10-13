$(document).ready(function(){
  var ship, vec, home
	$("input:radio[name=shipclass][disabled=false]:first").attr('checked', true)
	$(".ship-available").click(function(){
		$("#sLength").val($(this).data('length'))
	}); // ship-available
	$(".ship-taken").click(function(){
		// Remove
	}); //ship-taken
	$(".available").hover(function(){
		row = $(this).data('row')
		col = $(this).data('col')
		ship = $("input:radio[name=shipclass]:checked").val();
		vec = $("input:radio[name=orientation]:checked").val();
		if (ship != ''){
			highlightCells(col, row,vec,ship);
		} else {
		  showError('Please select a ship first');
	  }
	});
	$(".available").click(function(){
	   $.ajax({url:"/place/ship", 
	    data: {home : this.id, vector: vec, length: ship},
	    success : function(response){
	      if (response == true){
	        lockShip(home,vec,length);
        } else {
	        alert("Failed to place ship")
	      }
      }
	    });
    });
}); // document-ready

lockShip = function(home,vec,length){
  c = returnCellsShort(home, vec, length);
  $.each(c, function(cell) {
    alert(cell);
  });
}

clearHighlighting = function(){
	$('#yourShips').find("td.highlighted").each(function(){
		$(this).removeClass("highlighted");
	});
}

checkOverlapping = function(cell){
  return $.inArray(cell, takenCells) >= 0
}

showError = function(msg){
	$("#information").html(msg);
}

showConfirm = function(cell,ship){
  $("#information").html("Click to place your ship (" + ship + ") in cell " + cell);
}

highlightCells = function(col, row, vec, size){
  clearHighlighting();
  cell = (col+row);
	showConfirm(cell,size);
  cells = returnCells(col, row, vec, size);
  for(i=0;i<cells.length;i++){
    x = cells[i];
    if(checkOverlapping(x) > 0) {
      showError("Ships are overlapping");
      clearHighlighting();
      return false;
    } else if ($("#"+x).length > 0){
			$('#' + x).addClass("highlighted");
		} else {
		  showError("Ship is outside the grid");
			clearHighlighting();
			return false;
		}
  }
}
returnCells = function(col, row, vec, size){
  return returnCellsShort((col+row), vec, size);
}

returnCellsShort = function(cell, vec, size){
  cells = new Array();
	switch(vec){
		case 'E':
		  i = col.charCodeAt(0)
		  for(n=0;n<size;n++){
		    cell = String.fromCharCode(i+n) + row
		    cells.push(cell);
			}
			break;
		case 'S':
			for(i=0;i<size;i++){
				cell = col + (row+i)
				cells.push(cell);
			}
			break;
	}
	return cells;
}
