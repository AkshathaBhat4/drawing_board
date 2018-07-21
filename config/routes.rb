Rails.application.routes.draw do
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
  
  root "pages#home"
  resource :user_actions, only: [], defaults: {format: :json} do
    post :user_color
    post :cell_color
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
