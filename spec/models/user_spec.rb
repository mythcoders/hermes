# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  subject { create(:user) }

  describe "#create" do
    it "only allow emails that belong to mythcoders" do
    end
  end

  describe "#email_domain" do
    it "returns string when populated" do
      subject.email = "harry@johnson.net"
      expect(subject.email_domain).to eq("johnson.net")
    end

    it "returns nil when no empty" do
      subject.email = ""
      expect(subject.email_domain).to eq(nil)
    end
  end
end
