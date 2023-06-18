# https://github.com/rails/rails/blob/main/guides/source/layouts_and_rendering.md#the-status-option
class ApplicationController < ActionController::API
  def append_info_to_payload(payload)
    super
    payload[:user_id] = 42
  end

  def json_body
    JSON.parse(request.body.read)
  end
end
