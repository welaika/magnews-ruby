module Magnews
  module HeaderHelper
    def auth_header
      raise Magnews::MissingAuthToken if Magnews.auth_token.blank?
      { Authorization: "Bearer #{Magnews.auth_token}" }
    end

    def common_headers
      auth_header.merge({ content_type: :json, accept: :json })
    end
  end
end
