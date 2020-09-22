# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Messages API', type: :request do
  shared_examples 'forbidden request' do
    it 'responds with 403 status' do
      post '/api/messages', params: request, headers: api_basic_auth(client)
      expect(response.status).to eq(403)
    end
  end

  shared_examples 'bad request' do
    it 'responds with 400 status' do
      post '/api/messages', params: request, headers: api_basic_auth(client)
      expect(response.status).to eq(422)
    end
  end

  shared_examples 'successful request' do
    it 'responds with 201 status' do
      post '/api/messages', params: request, headers: api_basic_auth(client)
      expect(response.status).to eq(201)
    end

    it 'increases Message count' do
      expect do
        post '/api/messages', params: request, headers: api_basic_auth(client)
      end.to change { Message.count }.by(1)
    end

    it 'queues MailSortWorker' do
      expect do
        post '/api/messages', params: request, headers: api_basic_auth(client)
      end.to change { MailSortWorker.jobs.size }.by(1)
    end
  end

  describe 'POST mail' do
    context 'when no client is supplied' do
      it 'responds with unauthorized' do
        post '/api/messages'
        expect(response.status).to eq(401)
      end
    end

    context 'when client is not active' do
      let!(:client) { create(:client, :inactive) }
      it_behaves_like 'forbidden request'
    end

    context 'when client is active' do
      let(:client) { create(:client) }
      let(:to) { [Faker::Internet.email] }
      let(:subject) { Faker::Cannabis.buzzword }
      let(:environment) { 'test' }
      let(:sender) { Faker::Internet.email }
      let(:request) do
        {
          message:
            {
              to: to,
              subject: subject,
              environment: environment,
              sender: sender
            }
        }
      end

      context 'request has bare minimum' do
        it_behaves_like 'successful request'
      end

      context 'request is empty' do
        let(:request) { '' }
        it_behaves_like 'bad request'
      end

      context 'request does not include recipient' do
        let(:to) { '' }
        it_behaves_like 'bad request'
      end

      context 'request does not include subject' do
        let(:subject) { '' }
        it_behaves_like 'bad request'
      end

      context 'request does not include sender' do
        let(:sender) { '' }
        it_behaves_like 'bad request'
      end

      context 'request does not include environment' do
        let(:environment) { '' }
        it_behaves_like 'bad request'
      end
    end
  end
end
