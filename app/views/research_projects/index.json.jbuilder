json.array!(@research_projects) do |research_project|
  json.extract! research_project, :id, :name, :url, :b_date, :e_date, :description, :teacher_id
  json.url research_project_url(research_project, format: :json)
end
