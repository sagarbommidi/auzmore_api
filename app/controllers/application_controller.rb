class ApplicationController < ActionController::API
  include HttpAuthConcern
  rescue_from Exception, with: :internal_error

  private
  def render_response(opts={}, status_code=200)
    render json: {message: opts[:message].to_s, error: opts[:error].to_s}.to_json, status: status_code
    return
  end

  def internal_error
    render json: {message: '', error: 'unknown failure'}.to_json, status: 500
    return
  end
end
