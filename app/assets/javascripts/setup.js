recheckShips = function(){
  $("input:radio[name=shipclass][disabled=false]:first").attr('checked', true);
  setReady($("input:radio[name=shipclass][disabled=true]").size() == 4);
}

setReady = function(r){
  if (r == true){
    $("#ready_to_play").css("display", 'block');
    $("#placing_ships_info").css("display", "none");
  } else {
    $("#ready_to_play").css("display", "none");
    $("#placing_ships_info").css("display", "block");
  }
  ready = r;
}

connectCloseButtons = function(){
  $(".inputs-list a.close").click(function(){
    l = $(this).data('length');
    $.ajax({url:"/remove/ship",
      data: {length: l},
      success : function(response){
        if (response != false) {
          removeShip(l, response);
        }
      }
    });
  });
}

lockShip = function(home,vec,length){
  c = returnCells(home, vec, length);
  $.each(c, function(i,cell) {
    $('#' + cell).addClass("occupied");
  });
  $("#ship-"+length+" input").attr('disabled',true);
  recheckShips();
  $("#ship-"+length).append("<a class='close' data-length='"+length+"'>x</a>");
  connectCloseButtons();
}

removeShip = function(len,cells){
  $.each(cells, function(i,c){
    $("#"+c).removeClass("occupied");
  });
  $("#ship-"+len+" input").attr('disabled', false);
  $("#ship-"+len+" a.close").remove();
  recheckShips();
  connectCloseButtons();
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
  cells = returnCells(cell, vec, size);
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

returnCells = function(cell, vec, size){
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

var startSetup = function(){
  var ship, vec, home
  recheckShips();
  connectCloseButtons();
  if (!ready){ // READY
    $(".inputs-list input[disabled=false]").click(function(){
	    ship = $(this).data('length');
    }); // ship-available
    $(".available").hover(function(){
	    row = $(this).data('row')
	    col = $(this).data('col')
	    vec = $("input:radio[name=orientation]:checked").val();
	    ship = $("input:radio[name=shipclass]:checked").val();
	    if (ship != ''){
		    highlightCells(col, row, vec, ship);
	    } else {
	      showError('Please select a ship first');
      }
    });
    $(".available").click(function(){
      vec = $("input:radio[name=orientation]:checked").val();
      ship = $("input:radio[name=shipclass]:checked").val();
      $.ajax({url:"/place/ship", 
        data: {home : this.id, vector: vec, length: ship},
        success : function(response){
          if (response == true){
            lockShip(home,vec,ship);
          }
        }
      });
    });
  }
}

$(document).ready(function(){
  startSetup();
});
