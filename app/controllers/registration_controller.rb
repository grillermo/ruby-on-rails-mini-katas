class RegistrationController < ApplicationController
  def register 
    success = RegistrationForm.new(*registration_params).save

    if success
      render json: {success: true, message: 'Registration completed'}
    else
      render json: {success: false, message: result.message}, status: :unprocessable_entity
    end
  end


  def registration_params
    params.expect(:user_name, :company_name)
  end
end
