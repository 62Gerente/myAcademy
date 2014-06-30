MyAcademy::Application.routes.draw do
  devise_for :teachers

  devise_scope :teacher do
    get "/login", to: "devise/sessions#new", as: :login
    get "/signup", to: "devise/registrations#new", as: :signup
    get "/logout", to: "devise/sessions#destroy", as: :logout
  end

  get "/", to: "teachers#profile", as: :home
  get "/teachers/export/europass/xml", to: "export#europass_xml", as: :export_europass_xml
  get "/teachers/export/europass/pdf", to: "export#europass_pdf", as: :export_europass_pdf
  get "/teachers/export/pdf", to: "export#latex_pdf", as: :export_resume_pdf
  get "/teachers/export/md", to: "export#md", as: :export_resume_md
  get "/xml", to: "export#xslfo", as: :export_xslfo
  get "/search", to: "teachers#search", as: :search

  get "/oai" , to: "oai#index", as: :oai

  get "/linkedin/auth", to: "auth#auth", as: :auth_linkedin
  get "/linkedin/callback", to: "auth#callback", as: :linkedin_callback

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
