module ActionDispatch
  class ExceptionWrapper
    def status_code
      if @exception.is_a? ActionController::RoutingError
        405
      else
        self.class.status_code_for_exception(@exception.class.name)
      end
    end
  end
end
