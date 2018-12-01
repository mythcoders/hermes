require 'rails_helper'

RSpec.describe MailLog, type: :model do
  it { should validate_presence_of(:to) }
  it { should validate_presence_of(:subject) }
end
