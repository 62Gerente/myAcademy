MyAcademy::Application.routes.draw do
  devise_for :teachers

  devise_scope :teacher do
    get "/login", to: "devise/sessions#new", as: :login
    get "/signup", to: "devise/registrations#new", as: :signup
    get "/logout", to: "devise/sessions#destroy", as: :logout
  end

  get "/", to: "teachers#profile", as: :home
  get "/oai" , to: "oai#index", as: :oai
  get "/teachers/export/europass/xml", to: "export#europass_xml", as: :export_europass_xml
  get "/teachers/export/europass/pdf", to: "export#europass_pdf", as: :export_europass_pdf
  get "/teachers/export/pdf", to: "export#latex_pdf", as: :export_resume_pdf
  get "/teachers/export/md", to: "export#md", as: :export_resume_md
  get "/xslfo", to: "export#xslfo", as: :export_xslfo
  get "/search", to: "teachers#search", as: :search
  get "/profile" => "teachers#profile", as: :user_profile

  get "/linkedin/auth", to: "auth#auth", as: :auth_linkedin
  get "/linkedin/callback", to: "auth#callback", as: :linkedin_callback

  get "/:username" => "teachers#show", as: :user_profiles
  get "/ficheiros/:id/delete", to: "ficheiros#destroy", as: :ficheiro_delete
  get "/folders/:id/delete", to: "folders#destroy", as: :folder_delete

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
  resources :ficheiros
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
