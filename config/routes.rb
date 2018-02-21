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


  resources :users, except:[:show, :new, :create] do
    member do
      get :following, :followers
    end
    resources :events, except:[:index]
    resources :groups, except:[:show, :edit, :destroy, :index] do
      resources :group_user_relationships, only:[:create, :destroy, :show]
    end
  end
  #できればusers#showを/youにしたい

  get '/g/:access_id', to: 'groups#show', as: 'g'
  delete '/g/:access_id', to: 'groups#unfollow', as: 'g_del'
  get '/g/:access_id/edit', to: 'groups#edit', as: 'g_edit'
  patch '/g/:access_id', to: 'groups#update', as: 'g_update'
  get '/g/:access_id/d', to: 'detail_date_for_groups#index'
  get '/g/:access_id/da', to: 'detail_date_for_groups#index_for_auto'

  get '/g/:access_id/comments/new', to: 'comments#new', as: 'g_comment'
  post '/g/:access_id/comments/comments', to: 'comments#create', as: 'g_comments'

  get '/g/:access_id/answer/new', to: 'answers#new', as: 'g_answer'
  post '/g/:access_id/answer/comments', to: 'answers#create', as: 'g_answers'

  get '/events', to: 'events#index'

  get 'you', to: 'users#show', as: 'you'
  get '/participating', to: 'users#participating'
  get '/invited', to: 'users#invited'

  post '/submit', to: 'submissions#create'
  get '/s/:access_id', to: 'submissions#show', as: 's'
  delete '/s/:access_id', to: 'submissions#unfollow', as: 's_del'
  post '/addfromsubmission', to: 'submissions#add_from_submission'
  delete '/deletefromsubmission', to: 'submissions#delete_from_submission'
  post '/determinedetaildate', to: 'submissions#determine_detaildate'
  patch '/editsubmittedevent', to: 'submissions#edit_submitted_event'
  post '/expire', to: 'submissions#expire'
  post '/submitdetaildates', to: 'submissions#submit_detail_dates'
  #calendarのeventを突っ込む
  get '/s/:access_id/d', to: 'detail_dates#index'
  #自動回答用のeventを突っ込む
  get '/s/:access_id/da', to: 'detail_dates#index_for_auto'

  #reactで作成したformからのsubmit
  post '/time', to: 'api#receivetime'

  post 'determine_by_i_from_g', to: 'api#determine_by_i_from_g'
  post 'expiregroup', to: 'api#expire_group'
  post 'submitdetaildatesforgroup', to: 'api#submit_detaildates'

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

  #reactのtest用
  get '/react', to: 'static_pages#react'


  root 'static_pages#home'
end
