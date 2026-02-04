require 'rails_helper'

describe Product, type: :model do
  describe 'validations' do
    subject { build(:product) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cost) }
  end
end
