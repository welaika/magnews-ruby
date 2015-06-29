module Magnews
  module UrlHelper
    def url_for(resource)
      "#{Magnews.endpoint}/#{Magnews.api_version}/#{resource}"
    end
  end
end
