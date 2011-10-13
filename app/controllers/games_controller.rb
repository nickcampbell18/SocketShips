class GamesController < ApplicationController

	before_filter :require_uuid

	def game
		redirect_to "/step2" unless @u.locked_in?
	end
	
	def gameinfo
		render :partial => "gameinfo"
	end
	
	def shipspartial
		render :partial => "shipspartial"
	end
	
	def shots_json
		render :json => {
			:fired => @u.fired_cells,
			:hit => @u.hit_cells,
			:occupied => @u.occupied_cells,
			:lost => @u.lost_cells }
	end
	
	def finish
	end
	
	def shoot
		v = @g.shoot_and_hit?(@u, @u.other_player, params[:cell])

		if v == "-1"
			render :text => v
		else
			@g.reload
			@g.go_to_next_round?
			render :text => (v ? "1" : "0")
		end
	end

end

