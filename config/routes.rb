# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  scope :api do
    resources :tennis_courts do
      collection do
        get 'by_radius'
      end

      member do
        get 'reports'
      end
    end

    resources :tennis_court_suggestions, only: [:create]
  end
end
