require 'rails_helper'

describe RegistrationForm do
  describe '#save' do
    
    before(:each) do
      @instance = RegistrationForm.new(user_name, company_name)
    end

    context 'all arguments passed' do
      subject { @instance.save }

      let(:user_name) { 'Juan Paco Pedro' }
      let(:company_name) { 'De La mar' }

      it { is_expected.to be_truthy }

      it 'creates a new user' do
        expect { subject }.to change { User.count }.by 1
        expect(User.last.name).to eql(user_name)
      end

      it 'creates a new company' do
        expect { subject }.to change { Company.count }.by 1
      end
    end

    context 'some arguments are missing or empty' do
      let(:user_name) { nil }
      let(:company_name) { '' }

      subject { @instance.save }

    it { is_expected.to be_falsy }

      it 'returns an error message' do
        subject
        expect(@instance.message).to include "Validation failed: Name can't be blank"
      end
    end
  end
end
