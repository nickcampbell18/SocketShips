class ApplicationController < ActionController::Base
  protect_from_forgery
	include ApplicationHelper

	before_filter :require_uuid, :only => [:leave, :ping, :notify]

	def logout
		reset_session
		redirect_to :home
	end
	
	def leave #Like logging out, but removing your user too
		@p.destroy #unless @u.locked_in?
		reset_session
		redirect_to :home
	end
	
  def ping(type, vars = {})
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
    priority = type.match(/own/).nil? ? 2 : 1 #i.e. own = 1 for top-priority
    tmp = {:time => Time.now.iso8601, :str => str, :priority => priority}
    Pusher["private-#{current_player.uuid}"].trigger(type, tmp)
    current_player.messages.create(:message => str, :priority => priority)
    render :nothing => true
  end

  def notify(action)
    Pusher["private-#{current_player.uuid}"].trigger(action,nil)
    render :nothing => true
  end

	private

	def require_uuid
		unless logged_in?
			redirect_to :home
		else
			@p = current_player
			@g = current_game
			if @p.nil? or @g.nil?
				redirect_to :home, :flash => {:alert => 'Player or game could not be found (you may have been booted..)'}
			end
		end
	end
 
end
