Rails.application.routes.draw do

  resources :slide_games do
    post 'revert', :on => :member
    get 'list_versions', :on => :member
  end
  mount Ckeditor::Engine => '/ckeditor'
  get 'spelling', to: 'spellings#index'
  get 'spelling/play', to: 'spellings#play'
  get 'spelling/session_results', to: 'spellings#session_results'
  post 'spelling/check', to: 'spellings#check'
  get 'spelling/siguiente', to: 'spellings#siguiente'


  resources :pictures do
    get 'close_versions_list', :on => :member
  end

  # API
  namespace :api do
    namespace :v1 do
      get 'palabra/:word', to: 'endpoints#palabra'
    end
  end

  resources :variants do
    post 'revert', :on => :member
    get 'list_versions', :on => :member
  end


  resources :fshp_categories do
    post 'revert', :on => :member
    get 'list_versions', :on => :member
  end


  mount Commontator::Engine => '/commontator'

  MODEL_TABS.each do |model|
    resources model.to_sym do
      post 'revert', :on => :member
      post 'soft_delete', :on => :member
      post 'soft_restore', :on => :member
      get 'list_versions', :on => :member
      get :"autocomplete_#{model.singularize}_name", :on => :collection
    end
  end

  HIDDEN_MODELS.each do |model|
    resources model.to_sym do
      post 'revert', :on => :member
      get 'list_versions', :on => :member
    end
  end

  devise_for :users, path_prefix: 'auth', controllers: {omniauth_callbacks: "omniauth_callbacks",
                                                        registrations: 'registrations',
                                                        confirmations: 'confirmations' ,
                                                        passwords: 'passwords' }


  resources :users do
    post 'revert', :on => :member
    get 'list_versions', :on => :member
  end

  # require 'sidekiq/web'
  # mount Sidekiq::Web => '/sidekiq'
  #
  get 'frontends/_vote_reset', to: 'frontends#_vote_reset'
  get 'frontends/_vote_for', to: 'frontends#_vote_for'
  get 'frontends/_vote_against', to: 'frontends#_vote_against'
  get 'frontends/_vote_reset_thumbs', to: 'words#_vote_reset_thumbs'
  get 'frontends/_vote_for_thumbs', to: 'words#_vote_for_thumbs'
  get 'frontends/_vote_against_thumbs', to: 'words#_vote_against_thumbs'
  get 'frontends/_palabra_mas_resien', to: 'frontends#_palabra_mas_resien'
  get 'frontends/_palabra_mas_mira', to: 'frontends#_palabra_mas_mira'
  get 'frontends/rapport', to: 'frontends#rapport'

  get 'palabra/:word', to: 'frontends#palabra'
  post 'palabra', to: 'frontends#search'

  # get 'glosario/:glossary', to: 'frontends#glosario'

  get 'my_profile', to: 'frontends#my_profile'

  # post 'tra_palabra', to: 'frontends#tra_palabra'
  # post 'check_text', to: 'frontends#check_text'

  post 'glossaries/:id/edit/', to: 'glossaries#edit'
  get 'memory_games/:id/edit_game', to: 'memory_games#edit_game'
  get 'memory_games/:id/play_game', to: 'memory_games#play_game'
  post 'memory_games/:id/edit_game', to: 'memory_games#edit_game'
  get 'memory_game', to: 'memory_games#play_random_game'

  get 'slide_games/:id/edit_game', to: 'slide_games#edit_game'
  get 'slide_games/:id/play_game', to: 'slide_games#play_game'
  post 'slide_games/:id/edit_game', to: 'slide_games#edit_game'
  root :to => 'frontends#index'

end
