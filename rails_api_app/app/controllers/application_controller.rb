class ApplicationController < ActionController::API
  def append_info_to_payload(payload)
    super
    payload[:user_id] = 42
  end
end
