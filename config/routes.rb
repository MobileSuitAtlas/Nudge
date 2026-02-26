Rails.application.routes.draw do
  root "habits#today"
  resources :habits do
    post 'nudge', on: :member
  end
  post "habits/reset_focus", to: "habits#reset_focus", as: :reset_focus_habits
  post "habits/:id/set_focus", to: 'habits#set_focus', as: 'set_focus_habit'
  post "habits/:id/check_in", to: 'habits#check_in', as: 'check_in_habit'
  get "today", to: "habits#today"
  get "up" => "rails/health#show", as: :rails_health_check
end