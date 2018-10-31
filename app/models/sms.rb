class Sms
  attr_reader :from, :to, :text
  REQUIRED_PARAMS = [:from, :to, :text]

  def initialize(opts={})
    @from = opts['from']
    @to = opts['to']
    @text = opts['text']
  end

  # valid_to? and valid_from? methods will be generated.
  [:to, :from].each do |type|
    define_method("valid_#{type}?") do |account|
      account.phone_numbers.pluck(:number).include?(self.send(type))
    end
  end

  def process_inbound(account)
    unless valid_to?(account)
      return {error: "to parameter not found"}
    end
    if text.strip.downcase == 'stop'
      Rails.cache.write("block_#{from}_#{to}", expires_in: 4.minutes) do
        "Blocking from: #{from}, to: #{to}"
      end
    end
    {message: "inbound sms ok"}
  end

  def process_outbound(account)
    unless valid_from?(account)
      return {error: "from parameter not found"}
    end
    if blocked?
      return {error: "sms from #{from} to #{to} blocked by STOP request"}
    end
    send_sms
  end

  def send_sms
    if Rails.cache.read("outbound_#{from}_counter").to_i > 50
      return {error: "limit reached for #{from}"}
    end
    unless Rails.cache.exist?("outbound_#{from}")
      Rails.cache.delete("outbound_#{from}_counter")
      Rails.cache.fetch("outbound_#{from}", expires_in: 24.hours) do
        "First sent message: #{Time.now.to_i}"
      end
    end
    Rails.cache.increment("outbound_#{from}_counter", 1)
    {message: "outbound sms ok, #{Rails.cache.read("outbound_#{from}_counter", raw: true)}"}
  end

  def blocked?
    Rails.cache.exist?("block_#{from}_#{to}")
  end

  def validate_input
    error = ""
    if !valid_field?(from, 6, 16)
      error = "from is invalid"
    elsif !valid_field?(to, 6, 16)
      error = "to is invalid"
    elsif !valid_field?(text, 1, 120)
      error = "text is invalid"
    end
    { is_valid: error.empty?, error: error }
  end

  private
  def valid_field?(val, min, max)
    len = val.size
    val.kind_of?(String) && (len >= min && len <= max)
  end
end
