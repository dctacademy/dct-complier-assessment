json.extract! submission, :id, :statement, :output, :user_id, :language, :assignment_id, :practice_id, :created_at, :updated_at
json.url submission_url(submission, format: :json)
