MyAcademy::Application.routes.draw do
  devise_for :teachers

  devise_scope :teacher do
    get "/login", to: "devise/sessions#new"
    get "/signup", to: "devise/registrations#new"
    get "/logout", to: "devise/sessions#destroy", as: :logout
  end

  get "/", to: "teachers#profile", as: :home
  get "/teachers/export/xml", to: "export#xml", as: :export_xml
  get "/teachers/export/pdf", to: "export#pdf", as: :export_pdf

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
