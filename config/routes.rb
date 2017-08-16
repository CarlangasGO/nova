Rails.application.routes.draw do

  namespace :api do

    namespace :v1 do
    end
  end

  namespace :backend do
  end


  devise_for :members,  path: '/backend', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification'}, controllers: {
        omniauth_callbacks: 'backend/omniauth' 
      }

  root to: "frontend/home#index"
end
