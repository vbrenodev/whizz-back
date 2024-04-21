# frozen_string_literal: true

class MessageSchedulesController < ApplicationController
  before_action :set_message_schedule, only: %i[show update destroy]

  # GET /message_schedules
  def index
    @message_schedules = MessageSchedule.all

    render json: @message_schedules
  end

  # GET /message_schedules/1
  def show
    render json: @message_schedule
  end

  # POST /message_schedules
  def create
    @message_schedule = MessageSchedule.new(message_schedule_params)

    if @message_schedule.save
      render json: @message_schedule, status: :created, location: @message_schedule
    else
      render json: @message_schedule.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /message_schedules/1
  def update
    if @message_schedule.update(message_schedule_params)
      render json: @message_schedule
    else
      render json: @message_schedule.errors, status: :unprocessable_entity
    end
  end

  # DELETE /message_schedules/1
  def destroy
    @message_schedule.destroy!
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_message_schedule
    @message_schedule = MessageSchedule.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def message_schedule_params
    params.require(:message_schedule).permit(:messageId, :message, :scheduleDate, :whatsappNumber)
  end
end
