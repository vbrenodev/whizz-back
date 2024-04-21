# frozen_string_literal: true

class CreateMessageSchedules < ActiveRecord::Migration[7.1]
  def change
    create_table :message_schedules do |t|
      t.string :message_id
      t.string :message
      t.string :whatsapp_number
      t.datetime :schedule_date

      t.timestamps
    end
  end
end
