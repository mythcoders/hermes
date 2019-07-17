require 'rails_helper'

RSpec.describe MailLog, type: :model do
  it { should validate_presence_of(:to) }
  it { should validate_presence_of(:subject) }
  it { should validate_presence_of(:client) }
  it { should validate_presence_of(:environment) }
  it { should belong_to(:client) }

  context 'when being created' do
    context 'and client isn\'t active' do
      let(:client) { create(:client, :inactive)}
      subject { build(:mail_log, client: client) }

      it 'does not increase record count' do
        expect { subject.save! }.to change{ MailLog.count }.by(1)
      end
    end
  end

  # context 'after the record has been created' do
  #   subject { create(:mail_log) }
  # end
end
