json.array!(@publications) do |publication|
  json.extract! publication, :id, :title, :chapter, :pages, :publisher, :doi, :volume, :isbn, :issn, :date, :booktitle, :address, :uri, :journal, :number, :howpublished, :school, :publication_stype_id, :teacher_id, :research_project_id
  json.url publication_url(publication, format: :json)
end
