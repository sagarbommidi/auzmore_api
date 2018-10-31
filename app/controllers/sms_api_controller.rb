class SmsApiController < ApplicationController
  before_action :enforce_required_params, only: [:inbound_sms]
  before_action :validate_sms, only: [:inbound_sms]

  def inbound_sms
    resp = sms.process_inbound(@current_account)
    render_response(resp)
  end

  def outbound_sms
    resp = sms.process_outbound(@current_account)
    render_response(resp)
  end

  private
  def sms_params
    params.permit(:from, :to, :text)
  end

  def sms
    @sms ||= Sms.new(sms_params)
  end

  def enforce_required_params
    missing = Sms::REQUIRED_PARAMS.select { |param| [nil, ''].include?(params[param.to_s]) }
    unless missing.empty?
      error = "#{missing.join(', ')} #{missing.count > 1 ? 'are' : 'is'} missing"
      render_response({error: error})
    end
  end

  def validate_sms
    resp = sms.validate_input
    render_response({error: resp[:error]}) unless resp[:is_valid]
  end
end
