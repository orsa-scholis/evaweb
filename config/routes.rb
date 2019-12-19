# frozen_string_literal: true

Rails.application.routes.draw do
  root 'surveys#index'

  resources :surveys, only: :index do
    resources :survey_entries, only: %i[index create], as: 'entries'
    get 'dashboard', to: 'dashboards#index', on: :member
  end

  namespace :admin do
    resources :questions
    resources :question_groups
    resources :answer_possibilities
    resources :answers
    resources :survey_entries
    resources :surveys

    root to: 'questions#index'
  end
end
