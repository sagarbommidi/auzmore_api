Rails.application.routes.draw do
  post '/inbound/sms/' => 'sms_api#inbound_sms', as: :inbound_sms
  post '/outbound/sms/' => 'sms_api#outbound_sms', as: :outbound_sms
end
