Rails.application.routes.draw do

  get 'spelling', to: 'spellings#index'
  get 'spelling/play', to: 'spellings#play'
  get 'spelling/session_results', to: 'spellings#session_results'
  post 'spelling/check', to: 'spellings#check'
  get 'spelling/siguiente', to: 'spellings#siguiente'

  resources :recordings do
  post 'revert', :on => :member
  get 'list_versions', :on => :member
end

  resources :pictures do
  post 'revert', :on => :member
  get 'list_versions', :on => :member
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
      get 'list_versions', :on => :member
    end
  end

  HIDDEN_MODELS.each do |model|
    resources model.to_sym do
      post 'revert', :on => :member
      get 'list_versions', :on => :member
    end
  end

  devise_for :users, path_prefix: 'auth', controllers: {omniauth_callbacks: "omniauth_callbacks",
                                                        registrations: "registrations",
                                                        confirmations: 'confirmations' ,
                                                        passwords: 'passwords' }
  resources :users do
    post 'revert', :on => :member
    get 'list_versions', :on => :member
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

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
  get 'glosario/:glossary', to: 'frontends#glosario'

  get 'my_profile', to: 'frontends#my_profile'

  post 'palabra', to: 'frontends#search'
  post 'tra_palabra', to: 'frontends#tra_palabra'
  post 'check_text', to: 'frontends#check_text'

  root :to => 'frontends#index'

end
