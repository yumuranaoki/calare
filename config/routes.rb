Rails.application.routes.draw do

  get 'password_resets/new'
  get 'password_resets/edit'
  get 'user_relations/show'
  get 'user_relations/create'
  get 'user_relations/destroy'

  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'


  resources :users, except:[:new, :create] do
    member do
      get :following, :followers
    end
    resources :events
    resources :groups, except:[:show, :edit, :destroy] do
      resources :group_user_relationships, only:[:create, :destroy, :show]
    end
  end
  #できればusers#showを/youにしたい

  get '/g/:access_id', to: 'groups#show', as: 'g'
  delete '/g/:access_id', to: 'groups#destroy', as: 'g_del'
  get '/g/:access_id/edit', to: 'groups#edit', as: 'g_edit'
  patch '/g/:access_id', to: 'groups#update', as: 'g_update'
  get '/g/:access_id/comments/new', to: 'comments#new', as: 'g_comment'
  post '/g/:access_id/comments/comments', to: 'comments#create', as: 'g_comments'
  get '/g/:access_id/answer/new', to: 'answers#new', as: 'g_answer'
  post '/g/:access_id/answer/comments', to: 'answers#create', as: 'g_answers'
  get '/participating', to: 'groups#participating'
  get '/invited', to: 'groups#invited'


  resources :relationships, only:[:create, :destroy, :show]
  resources :user_relations, only:[:create, :destroy, :show]

  get '/redirect', to: 'google_calendars#redirect', as: 'redirect'
  get '/callback', to: 'google_calendars#callback', as: 'callback'
  get '/list_all', to: 'google_calendars#list_all', as: 'list_all'
  get '/list_part', to: 'google_calendars#list_part', as: 'list_part'

  delete '/deleteevent', to: 'events#delete_event'
  post '/createevent', to: 'events#create_event'
  patch '/editevent', to: 'events#edit_event'

  resources :account_activations, only:[:edit]
  resources :password_resets, only:[:new, :edit, :update, :create]

  get '/react', to: 'static_pages#react'

  root 'static_pages#home'
end
