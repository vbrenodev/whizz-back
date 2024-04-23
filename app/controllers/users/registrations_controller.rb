# frozen_string_literal: true

# app/controllers/users/registrations_controller.rb

module Users
  class RegistrationsController < Devise::RegistrationsController # rubocop:disable Style/Documentation
    respond_to :json

    def create
      build_resource(sign_up_params)

      return handle_successful_create resource if resource.save

      handle_failed_create resource
    end

    def update
      self.resource = find_resource_by_email

      return resource_not_found unless resource

      resource_updated = update_resource(resource, account_update_params)
      yield resource if block_given?
      return handle_successful_update resource if resource_updated

      handle_failed_update resource
    end

    def destroy
      self.resource = find_resource_by_email
      return resource_not_found unless resource

      resource.soft_delete
      sign_out(resource_name) if resource == current_user
      respond_with resource, 'User successfully deleted.', location: after_sign_out_path_for(resource_name)
    end

    protected

    def sign_up(resource)
      expire_data_after_sign_in!
      respond_with resource, 'Signed up successfully.'
    end

    def update_resource(resource, params)
      resource.update_without_password(params)
    end

    def account_update_params
      account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
      account_update_params.reject! do |k, v|
        v.blank? && k.in?(%w[name email password password_confirmation])
      end
      return account_update_params if account_update_params

      respond_with nil, 'Email is required.'
    end

    private

    def permitted_params
      params.require(:user).permit(:email)
    end

    def find_resource_by_email
      User.where(deleted_at: nil).find_by(email: permitted_params[:email])
    end

    def handle_successful_create(resource)
      return sign_up resource if current_user

      sign_up_and_log_in resource_name, resource if resource.active_for_authentication?
    end

    def handle_successful_update(resource)
      bypass_sign_in resource, scope: resource_name if sign_in_after_change_password? &&
                                                       resource == current_user

      respond_with resource, 'User updated successfully.'
    end

    def handle_failed_update(resource)
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource, 'User could not be updated.'
    end

    def handle_failed_create(resource)
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource, 'User could not be created.'
    end

    def sign_up_and_log_in(resource_name, resource)
      sign_in(resource_name, resource)
      respond_with resource, 'Signed up and Logged successfully.'
    end

    def respond_with(resource, message, _opts = {})
      return resource_not_found message unless resource
      return resource_success resource, message if resource.persisted?

      resource_failed message
    end

    def resource_success(resource, message)
      render json: {
        message: message || 'Signed up successfully.',
        user: resource
      }, status: :ok
    end

    def resource_updated
      render json: {
        message: 'User updated successfully.',
        user: @user
      }, status: :ok
    end

    def resource_failed(message)
      render json: {
        message: message || 'Something went wrong.'
      }, status: :unprocessable_entity
    end

    def resource_not_found(message = nil)
      render json: {
        message: message || 'User not found.'
      }, status: :not_found
    end
  end
end
