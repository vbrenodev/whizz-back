# frozen_string_literal: true

# app/controllers/users/sessions_controller.rb

module Users
  class SessionsController < Devise::SessionsController # rubocop:disable Style/Documentation
    respond_to :json

    def create
      return resource_not_found if find_user_by_email.deleted_at?

      self.resource = warden.authenticate!(auth_options)
      sign_in(resource_name, resource)
      yield resource if block_given?
      respond_with resource, location: after_sign_in_path_for(resource)
    end

    private

    def find_user_by_email
      User.find_by(email: sign_in_params[:email])
    end

    def respond_with(_resource, _opts = {})
      render json: {
        message: 'You are logged in.',
        user: current_user
      }, status: :ok
    end

    def respond_to_on_destroy
      return log_out_failure if current_user

      log_out_success
    end

    def log_out_success
      render json: { message: 'You are logged out.' }, status: :ok
    end

    def log_out_failure
      render json: { message: 'Hmm nothing happened.' }, status: :unauthorized
    end

    def resource_not_found(message = nil)
      render json: {
        message: message || 'User not found.'
      }, status: :not_found
    end
  end
end
