json.id @poll.id
json.question @poll.question
json.created_at @poll.created_at.iso8601
json.updated_at @poll.updated_at.iso8601
json.url poll_url(@poll, format: :json)
json.options @poll.options, partial: "options/option", as: :option
