Rails.application.routes.draw do
  root "habits#index"

  resources :habits do
    post "nudge", on: :member
    post "toggle_reminder", on: :member
    post "archive", on: :member
    post "unarchive", on: :member
    resources :entries, only: [ :create, :destroy ]
  end

  resources :tags, only: [ :index, :create, :update, :destroy ]

  post "habits/reset_focus", to: "habits#reset_focus", as: :reset_focus_habits
  post "habits/:id/set_focus", to: "habits#set_focus", as: "set_focus_habit"
  post "habits/:id/check_in", to: "habits#check_in", as: "check_in_habit"
  post "toggle_theme", to: "habits#toggle_theme"
  get "export", to: "habits#export"
  get "today", to: "habits#today"
  get "up" => "rails/health#show", as: :rails_health_check
end
