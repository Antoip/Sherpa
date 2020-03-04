Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # namespace :dashboard do
  #   resources :users, only: %i[show edit update]
  #   resources :teacher_divisions, only: %i[show]
  #   resources :flashcards
  #   resources :forums
  #   resources :messages
  # end

  namespace :teachers do
    root to: 'teachers#show'
    resources :courses, only: [:show] do
      resources :students, only: [:index, :show]
    end
    resources :flashcards, only: [:index, :destroy, :update, :create]
  end
  resources :materials, only: [:index, :show]
  resources :chapters, only: [:new, :create, :edit, :update, :destroy] do
    resources :flashcards, only: [:index, :show, :create]
  end
  resources :courses, only: [:show]

  resources :forums, only: [:create, :update, :show] do
    resources :messages, only: [:create, :show]
  end

  namespace :students do
    root to: 'courses#index'
      resources :courses, only: [:index, :show] do
        resources :feedbacks, only: [:create, :update, :delete]
        resources :forums, only: [:show, :create]
    end
    resources :sessions, only: [:show, :create]
  end

  get '/flashcards_notifications', to: 'teachers/teachers#trigger_flashcard_notifications', as: 'flashcards_notifications'

  mount ActionCable.server => "/cable"
end
