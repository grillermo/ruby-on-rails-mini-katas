class RegistrationForm
  attr_reader :message
  pattr_initialize :user_name, :company_name

  def save
    ActiveRecord::Base.transaction do
      User.create!(name: @user_name) && Company.create!(name: @company_name)
      @message = "Registration completed"
      true
    end
  rescue ActiveRecord::RecordInvalid => error
    @message = error.message
    false
  end
end
