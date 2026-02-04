class RegistrationForm
  attr_reader :message
  pattr_initialize :user_name, :company_name

  def save
    User.create!(name: @user_name) && Company.create!(name: @company_name)
    @message = 'Registration completed'

    true
  rescue ActiveRecord::RecordInvalid => error
    @message = error.message

    false
  end
end
