Rails.application.routes.draw do

  resources :licenses do
    post 'revert', :on => :member
    get 'list_versions', :on => :member
  end
  mount Ckeditor::Engine => '/ckeditor'
  get 'spelling', to: 'spellings#index'
  get 'spelling/play', to: 'spellings#play'
  get 'spelling/session_results', to: 'spellings#session_results'
  post 'spelling/check', to: 'spellings#check'
  get 'spelling/siguiente', to: 'spellings#siguiente'


  # API
  namespace :api do
    namespace :v1 do
      get 'palabra/:word', to: 'endpoints#palabra'
      get 'list_words_with_this_length/:length', to: 'list_words_with_this_length#list'
    end
  end

  mount Commontator::Engine => '/commontator'

  resources :memory_games do
    get :"autocomplete_word_name", :on => :collection
  end

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



  devise_for :users, path_prefix: 'auth', controllers: {registrations: 'registrations',
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

  get 'my_profile', to: 'frontends#my_profile'

  # post 'tra_palabra', to: 'frontends#tra_palabra'
  # post 'check_text', to: 'frontends#check_text'


  get 'glosario/:id', to: 'glossaries#show_glossary'
  match 'glosario/:id/edit_glossary', to: 'glossaries#edit_glossary', via: [:get, :post]
  get 'fuente/:id', to: 'sources#show_source'
  get 'meta/:id', to: 'goals#show_goal'

  get 'dijkhoff_goals', to: 'goals#show_dijkhoff_goals'


  get '/flora', to: 'frontends#flora'
  get '/founa', to: 'frontends#founa'
  get '/músika', to: 'frontends#músika'
  get '/musika', to: 'frontends#músika'
  get '/konstrukshon', to: 'frontends#konstrukshon'

  get 'memory_games/:id/play_memory_game', to: 'memory_games#play_memory_game'
  match 'memory_games/:id/edit_memory_game', to: 'memory_games#edit_memory_game', via: [:get, :post]
  get 'memory_game', to: 'memory_games#play_random_memory_game'
  get 'memory_game_flora', to: 'memory_games#play_random_memory_game_flora'
  get 'memory_game_founa', to: 'memory_games#play_random_memory_game_founa'
  get 'memory_game_musika', to: 'memory_games#play_random_memory_game_musika'

  get 'slide_games/:id/edit_game', to: 'slide_games#edit_game'
  get 'slide_games/:id/play_game', to: 'slide_games#play_game'
  post 'slide_games/:id/edit_game', to: 'slide_games#edit_game'
  root :to => 'frontends#index'




end
