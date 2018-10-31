module ActionController
  module HttpAuthentication
    module Basic
      def authentication_request(controller, realm, message)
        message ||= "HTTP Basic: Access Denied\n"
        controller.headers["WWW-Authenticate"] = %(Basic realm="#{realm.tr('"'.freeze, "".freeze)}")
        controller.status = 403
        controller.response_body = message
      end
    end
  end
end
