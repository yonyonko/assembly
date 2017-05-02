json.extract! assembly, :id, :name, :description, :created_at, :updated_at, :user.id
json.url assembly_url(assembly, format: :json)