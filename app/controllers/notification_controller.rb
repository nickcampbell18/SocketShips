class NotificationController < ApplicationController

  protect_from_forgery :except => :auth
  
  def auth
    if true
      response = Pusher[params[:channel_name]].authenticate(params[:socket_id])
      render :json => response
    else
      render :text => "Not authorized", :status => '403'
    end
  end
  
  def hit_own_ship()
    ping "nick", "hit_own_ship", {:ship => "Destroyer", :cell => "G3", :priority => 2}
  end
  
  def hit_their_ship(ship = 'Battleship', cell = 'B3')
    ping "nick", "hit_their_ship", {:ship => ship, :cell => cell, :priority => 2}
  end
  
  def lost_own_ship(ship = 'Battleship')
    ping "nick", "lost_own_ship", {:ship => ship, :priority => 1}
  end  

  def lost_their_ship(ship = 'Destroyer')
    ping "nick", "lost_their_ship", {:ship => ship, :priority => 1}
  end
  
  def ready_to_move
    json_notify "nick", "ready"
  end
  
  
end
