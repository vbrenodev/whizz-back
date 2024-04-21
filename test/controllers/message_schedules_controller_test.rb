# frozen_string_literal: true

require 'test_helper'

class MessageSchedulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @message_schedule = message_schedules(:one)
  end

  test 'should get index' do
    get message_schedules_url, as: :json
    assert_response :success
  end

  test 'should create message_schedule' do
    assert_difference('MessageSchedule.count') do
      post message_schedules_url,
           params: { message_schedule: { message: @message_schedule.message, message_id: @message_schedule.message_id, schedule_date: @message_schedule.schedule_date, whatsapp_number: @message_schedule.whatsapp_number } }, as: :json
    end

    assert_response :created
  end

  test 'should show message_schedule' do
    get message_schedule_url(@message_schedule), as: :json
    assert_response :success
  end

  test 'should update message_schedule' do
    patch message_schedule_url(@message_schedule),
          params: { message_schedule: { message: @message_schedule.message, message_id: @message_schedule.message_id, schedule_date: @message_schedule.schedule_date, whatsapp_number: @message_schedule.whatsapp_number } }, as: :json
    assert_response :success
  end

  test 'should destroy message_schedule' do
    assert_difference('MessageSchedule.count', -1) do
      delete message_schedule_url(@message_schedule), as: :json
    end

    assert_response :no_content
  end
end
