Socketships::Application.routes.draw do

  # Setup
  root :to => 'setup#home'
  match '/home' => 'setup#home'
  match '/step1' => 'setup#step1'
  match '/step2' => 'setup#step2'
  match '/place/ship' => 'setup#place_ship'
  match '/remove/ship' => 'setup#remove_ship'
  match '/remove/ship-:length' => 'setup#remove_ship'

  # Playing
  match '/game' => 'games#game'

  # Pings etc
  post 'pusher/auth' => 'notification#auth'
  get "notification/hit_own_ship"
  get 'notification/lost_own_ship'
  get 'notification/hit_their_ship'
  get 'notification/lost_their_ship'
  get 'notification/ready_to_move'

  # Other
  match '/leave' => 'application#leave'

end
