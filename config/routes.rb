Socketships::Application.routes.draw do
 
 devise_for :players

 root :to => 'setup#home'
 
 post 'pusher/auth' => 'notification#auth'
 
 get "notification/hit_own_ship/:ship/:cell" => 'notification#hit_own_ship'
 get 'notification/lost_own_ship'
 get 'notification/hit_their_ship'
 get 'notification/lost_their_ship'
 get 'notification/ready_to_move'
 
end
