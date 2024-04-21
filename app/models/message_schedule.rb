# frozen_string_literal: true

class MessageSchedule < ApplicationRecord
  validates :message, :schedule_date, :whatsapp_number, presence: true
  before_create :set_message_id

  private

  def set_message_id
    self.message_id = SecureRandom.uuid
  end
end
