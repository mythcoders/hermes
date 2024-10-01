class Webhook::SES::Processors::Ignored < Webhook::SES::Processors::Base
  def process
    true
  end
end
