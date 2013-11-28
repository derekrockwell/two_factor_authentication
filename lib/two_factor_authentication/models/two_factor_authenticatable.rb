require 'two_factor_authentication/hooks/two_factor_authenticatable'
module Devise
  module Models
    module TwoFactorAuthenticatable
      extend ActiveSupport::Concern

      module ClassMethods
        ::Devise::Models.config(self, :login_code_random_pattern, :max_login_attempts)
      end

      def need_two_factor_authentication?(request)
        true
      end

      def generate_two_factor_code
        self.class.login_code_random_pattern.gen
      end

      def send_two_factor_authentication_code(code)
        p "Code is #{code}"
      end

      def max_login_attempts?
        second_factor_attempts_count >= self.class.max_login_attempts
      end

      def tfa_remember!(extend_period=false)
        self.tfa_rememberable_token = self.class.tfa_remember_token if generate_tfa_token?
        self.tfa_rememberable_created_at = Time.now.utc if generate_tfa_timestamp?(extend_period)
        save(:validate => false)
      end

      def tfa_remember_for
        7.days
      end

      # Remember token should be expired if expiration time not overpass now.
      def tfa_remember_expired?
        tfa_rememberable_created_at.nil? || (tfa_remember_expires_at <= Time.now.utc)
      end

      # Remember token expires at created time + remember_for configuration
      def tfa_remember_expires_at
        tfa_rememberable_created_at + tfa_remember_for
      end

      protected

        def generate_tfa_token?
          respond_to?(:tfa_remember_token) && tfa_expired?
        end

        def tfa_remember_token
          Devise.friendly_token
        end

        def generate_tfa_timestamp?(extend_period) #:nodoc:
          extend_period || tfa_rememberable_created_at.nil? || tfa_remember_expired?
        end

        module ClassMethods
          def serialize_tfa_cookie(user)
            [user.to_key, user.tfa_rememberable_token]
          end

          def serialize_tfa_from_cookie(id, tfa_token)
            record = to_adapter.get(id)
            record if record && record.tfa_rememberable_token == tfa_token && !record.tfa_remember_expired?
          end
        end
    end
  end
end
