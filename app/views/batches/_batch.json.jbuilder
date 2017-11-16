json.extract! batch, :id, :title, :start_date, :end_date, :course_id, :is_completed, :created_at, :updated_at
json.url batch_url(batch, format: :json)
