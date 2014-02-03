MyAcademy::Application.routes.draw do
  devise_for :teachers


  devise_scope :teacher do
    get "/login" => "devise/sessions#new"
    get "/signup" => "devise/registrations#new"
    get "/logout" => "devise/sessions#destroy", :as => :logout
  end

  get "/" => "teachers#profile", :as => :home


  resources :theses
  resources :thesis_supervisions
  resources :teachers
  resources :academic_degrees
  resources :academic_informations
  resources :activities
  resources :activity_types
  resources :authors
  resources :cosupervisors
  resources :courses
  resources :deliverables
  resources :editors
  resources :entities
  resources :files
  resources :folders
  resources :hobbies
  resources :institutions
  resources :managements
  resources :publication_types
  resources :publications
  resources :research_projects
  resources :roles
  resources :subjects
  resources :tags
  resources :thesis_examinations
  resources :teachers
end
