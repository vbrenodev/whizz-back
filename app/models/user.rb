# frozen_string_literal: true

class User < ApplicationRecord # rubocop:disable Style/Documentation
  devise :database_authenticatable, :registerable, :jwt_authenticatable,
         jwt_revocation_strategy: JwtDenylist

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, if: :new_record?, on: %i[create]
  validates :password_confirmation, presence: true, if: :new_record?, on: %i[create]

  def soft_delete
    # assuming you have deleted_at column added already
    update_attribute(:deleted_at, Time.current)
  end
end
