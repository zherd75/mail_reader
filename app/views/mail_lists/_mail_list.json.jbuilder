json.extract! mail_list, :id, :subject, :message, :date, :created_at, :updated_at
json.url mail_list_url(mail_list, format: :json)
