class CreateScheduledMessage < ActiveRecord::Migration[7.1]
  def change
    create_table :scheduled_messages do |t|
      t.string :messageId
      t.string :message
      t.datetime :scheduleDate
      t.integer :whatsappNumber

      t.timestamps
    end
  end
end
