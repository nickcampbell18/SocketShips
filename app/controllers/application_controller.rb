class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def ping(uuid, type, vars = {})
    tmp = {}
    @p = Player.first
    str = case type
      when "hit_own_ship"
        t :hit_own_ship, vars
      when "hit_their_ship"
        t :hit_their_ship, vars
      when "lost_own_ship"
        t :lost_own_ship, vars
      when "lost_their_ship"
        t :lost_their_ship, vars
    end
    tmp[:time] = Time.now.iso8601
    tmp[:str] = str
    Pusher["private-#{uuid}"].trigger(type, tmp)
    @p.messages.create(:message => str, :priority => vars[:priority])
    render :nothing => true
  end
  
  def json_notify(uuid, action)
    Pusher["private-#{uuid}"].trigger(action,nil)
    render :nothing => true
  end
  
end
