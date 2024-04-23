# frozen_string_literal: true

class JwtDenylist < ApplicationRecord # rubocop:disable Style/Documentation
  include Devise::JWT::RevocationStrategies::Denylist

  self.table_name = 'jwt_denylist'
end
