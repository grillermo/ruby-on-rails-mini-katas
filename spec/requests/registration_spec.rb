require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  describe "POST /register" do
    subject { post(register_path, params: { user_name: 'wow', company_name: 'coke'}) }

    it 'returns 200' do
      subject
      expect(response).to have_http_status(:ok)
    end

    it 'creates a new user' do
      expect { subject }.to change { User.count }.by 1
    end

    it 'creates a new company' do
      expect { subject }.to change { Company.count }.by 1
    end
  end
end
