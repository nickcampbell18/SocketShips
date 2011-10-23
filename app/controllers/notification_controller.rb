class NotificationController < ApplicationController
  protect_from_forgery :except => :auth
  
  def auth
    if logged_in?
      response = Pusher[params[:channel_name]].authenticate(params[:socket_id])
      render :json => response
    else
      render :text => "Not authorized", :status => '403'
    end
  end
  
  def hit_own_ship()
    ping "hit_own_ship", params #ship, cell
  end
  
  def hit_their_ship
    ping "hit_their_ship", params #ship, cell
  end
  
  def lost_own_ship
    ping "lost_own_ship", params #ship
  end  

  def lost_their_ship
    ping "lost_their_ship", params #ship
  end
  
  def ready_to_move
    notify "ready"
  end
  
  
end
