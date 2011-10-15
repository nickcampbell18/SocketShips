class SetupController < ApplicationController

	before_filter :require_uuid, :except => :home

	def home
		if session[:player]
			redirect_to :game
		end
		
		if request.post?
			g = Game.create(:name => params[:gameName])
			p = g.players.create(:name => params[:userName])
			if g.valid? and p.valid?
				session[:player] = p.uuid
				redirect_to :step1
			else
				str = ''
				str += 'You must specify a valid game name<br />' unless g.valid?
				str += 'You must specify a valid user name' unless u.valid?
				flash.now[:alert] = str.html_safe
			end
		end
	end

	def step1
		# Only admins get here so...
		redirect_to "/game" if @g.started?
	end

	def step2
		redirect_to "/game" if @g.started?
		if request.post?
			# Make that ship mofo
			flash.now[:alert] = "That ship was invalid" unless @p.create_ship?(params[:ship])
			@p.ships.reload
		end
	end

	def lock
		@p.locked = true
		@p.save
		redirect_to "/game"
	end

	def start_game
		if @p.is_admin?
			@g.started = true
			@g.save
		end
		redirect_to "/game"
	end

	def remove_ship
		s = @p.ships.where(:length => params[:length])
		unless s.empty?
		  render :json => s.first.cells
		  s.first.destroy
	  else
	    render :json => false
    end
	end
	
	def place_ship
	  l,h,v = [params[:length], params[:home], params[:vector]]
	  s = @p.ships.create(:length => l, :home => h, :vector => v)
	  render :json => (s.valid? ? {:cells => s.cells} : false)
	end

	def enter_from_user
		p = Player.find_by_uuid(params[:uuid])
		unless p.nil?
			session[:player] = p.uuid
			redirect_to :step2
		else
			redirect_to :home, :flash => {:alert => "User code not recognised"}
		end
	end

	def enter_from_game
		redirect_to :step2 if session[:uuid]
		@g = Game.find_by_uuid(params[:gameCode])
		if request.post? and !@g.nil?
			p = @g.users.create(:name => params[:userName])
		  unless p.valid?
				session[:player] = p.uuid
				redirect_to :step2
			else
				flash.now[:alert] = "Sorry, that name is already taken, or the game has already started."
			end
		end
	end

end
