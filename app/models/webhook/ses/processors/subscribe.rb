class Webhook::SES::Processors::Subscribe < Webhook::SES::Processors::Base
  def process
    Net::HTTP.get_response(subscribe_uri).is_a? Net::HTTPSuccess
  end

  private

  def subscribe_uri
    @subscribe_uri ||= URI notification.json_data["SubscribeURL"]
  end
end
