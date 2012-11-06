SesCatcher::Application.routes.draw do

  root :to => 'emails#show'

  resources :emails
  
  match '/complaints', :to => 'emails#process_ses_notifications'

end
