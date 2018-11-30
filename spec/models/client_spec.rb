# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Client, type: :model do
  subject { create(:client) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:owner) }
  it { should validate_presence_of(:reroute_email) }
  it { should validate_presence_of(:api_secret) }
  it { should validate_presence_of(:api_key) }
  it { should validate_length_of(:name).is_at_most(50) }
  it { should validate_length_of(:owner).is_at_most(50) }
  it { should validate_length_of(:reroute_email).is_at_most(60) }
  it { should validate_length_of(:api_secret).is_at_most(128) }
  it { should validate_length_of(:api_key).is_at_most(128) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:api_secret) }
  it { should validate_uniqueness_of(:api_key) }
end
