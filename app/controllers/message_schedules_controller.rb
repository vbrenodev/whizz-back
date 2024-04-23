# frozen_string_literal: true

class MessageSchedulesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message_schedule, only: %i[show update destroy]

  def index
    @message_schedules = MessageSchedule.all

    render json: @message_schedules
  end

  def show
    render json: @message_schedule
  end

  def create
    @message_schedule = MessageSchedule.new(message_schedule_params)

    if @message_schedule.save
      render json: @message_schedule, status: :created, location: @message_schedule
    else
      render json: @message_schedule.errors, status: :unprocessable_entity
    end
  end

  def update
    if @message_schedule.update(message_schedule_params)
      render json: @message_schedule
    else
      render json: @message_schedule.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @message_schedule.destroy!
  end

  private

  def set_message_schedule
    @message_schedule = MessageSchedule.find(params[:id])
  end

  def permitted_params
    params.require(:message_schedule).permit(:message, :schedule_date, :whatsapp_number)
  end

  def message_schedule_params
    message_schedule_params = permitted_params
    message_schedule_params.merge!(formatted_schedule_date) if permitted_params[:schedule_date]

    message_schedule_params
  end

  def formatted_schedule_date
    {
      schedule_date: Time.at(permitted_params[:schedule_date])
    }
  end
end
