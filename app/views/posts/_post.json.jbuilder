json.extract! post, :id, :title, :body, :user_id, :created_at, :updated_at
json.url user_post_url(@user,post, format: :json)