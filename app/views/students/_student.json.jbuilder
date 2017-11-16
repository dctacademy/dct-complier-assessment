json.extract! student, :id, :name, :email, :mobile, :created_at, :updated_at
json.url student_url(student, format: :json)
