# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Mail API', type: :request do
  shared_examples 'responds with forbidden' do
    it 'responds with forbidden' do
      post '/api/mail', params: request, headers: api_basic_auth(client)
      expect(response.status).to eq(403)
    end
  end

  shared_examples 'responds with bad request' do
    it 'responds with bad request' do
      post '/api/mail', params: request, headers: api_basic_auth(client)
      expect(response.status).to eq(400)
    end
  end

  shared_examples 'responds with created' do
    it 'responds with created' do
      post '/api/mail', params: request, headers: api_basic_auth(client)
      expect(response.status).to eq(201)
    end
  end

  describe 'POST mail' do
    context 'when no client is supplied' do
      it 'responds with unauthorized' do
        post '/api/mail'
        expect(response.status).to eq(401)
      end
    end

    context 'when client is not active' do
      let(:client) { create(:client, :inactive) }
      it_behaves_like 'responds with forbidden'
    end

    context 'when client is active' do
      let(:client) { create(:client) }

      context 'request is empty' do
        let(:request) { '' }
        it_behaves_like 'responds with bad request'
      end

      context 'request has bare minimum' do
        let(:request) { { to: [Faker::Internet.email], subject: Faker::Cannabis.buzzword, environment: 'test' } }
        it_behaves_like 'responds with created'
      end

      context 'request does not include sender' do
        let(:request) { { to: '', subject: Faker::Cannabis.buzzword, environment: 'test' } }
        it_behaves_like 'responds with bad request'
      end

      context 'request does not include subject' do
        let(:request) { { to: [Faker::Internet.email], subject: '', environment: 'test' } }
        it_behaves_like 'responds with bad request'
      end

      context 'request does not include environment' do
        let(:request) { { to: [Faker::Internet.email], subject: Faker::Cannabis.buzzword, environment: '' } }
        it_behaves_like 'responds with bad request'
      end
    end
  end
end
