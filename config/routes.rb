MyAcademy::Application.routes.draw do
  devise_for :teachers


  devise_scope :teacher do
    get "/login" => "devise/sessions#new"
    get "/signup" => "devise/registrations#new"
    get "/logout" => "devise/sessions#destroy", :as => :logout
  end

  get "/" => "teachers#profile", :as => :home
end
