# frozen_string_literal: true

class CreateMessageSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :message_schedules do |t|
      t.string :messageId
      t.string :message
      t.datetime :scheduleDate
      t.integer :whatsappNumber

      t.timestamps
    end
  end
end
