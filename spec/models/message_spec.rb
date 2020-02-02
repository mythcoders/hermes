# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message, type: :model do
  it { should validate_presence_of(:sender) }
  it { should validate_presence_of(:subject) }
  it { should validate_presence_of(:client) }
  it { should validate_presence_of(:environment) }
  it { should validate_presence_of(:tracking_id) }
  it { should validate_presence_of(:content_type) }
  it { should belong_to(:client) }

  context 'when being created' do
    context 'and client isn\'t active' do
      let(:client) { create(:client, :inactive) }
      subject { build(:message, client: client) }

      it 'does not increase record count' do
        expect { subject.save }.to change { Message.count }.by(0)
      end
    end
  end

  # context 'after the record has been created' do
  #   subject { create(:message) }
  # end
end
