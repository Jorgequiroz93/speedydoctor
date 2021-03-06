require 'faraday'
require 'faraday/net_http'
require 'date'
# require 'pry-byebug'
Faraday.default_adapter = :net_http

class ConsultationsController < ApplicationController

  def show
    @consultation = Consultation.find(params[:id])
    @report = @consultation.report
    @doctor = @consultation.doctor
    @patient = @consultation.patient
    @room_url = @consultation.room_url
  end

  def create
    @doctor = User.find(params[:doctor_id])
    @consultation = Consultation.new
    @consultation.start_time = DateTime.now
    @consultation.end_time = DateTime.now
    @consultation.doctor = @doctor
    @consultation.patient = current_user
    @consultation.status = 'calling'
    @consultation.room_url = create_room
    if @consultation.save!
      @report = Report.new
      @report.consultation = @consultation
      @report.content = ""
      @report.prescription = ""
      @report.save!
      # @consultation.id Notify Doctor of the new Call/consultation
      ActionCable.server.broadcast("general", { doctor_id: @doctor.id, consultation_id: @consultation.id })
      @doctor.status = "Busy"
      @doctor.save!
      redirect_to consultation_path(@consultation)
    else
      render 'doctors/show'
    end
  end

  def update
    @consultation = Consultation.find(params[:id])
    @consultation.update(consultation_params)

    if params[:status] == "finished"
      @doctor = @consultation.doctor
      @doctor.status = "Available"
      @doctor.save!
    end
    @report = @consultation.report
    @report.prescription = params["prescription"] if params["prescription"]
    @report.content = params["content"] if params["content"]
    @report.save!
    ActionCable.server.broadcast(
      "reporting",
      { patient_id: @consultation.patient_id,
        consultation_id: @consultation.id,
        prescription: params["prescription"],
        advice: params["content"] }
    )
  end

  private

  def create_room
    res = Faraday.post "https://api.daily.co/v1/rooms/" do |req|
      req.body = { properties: { enable_chat: true, enable_people_ui: false, enable_pip_ui: true }}.to_json
      req.headers['Content-Type'] = 'application/json'
      req.headers['Authorization'] = 'Bearer 805ef46e7bdb8a21f60dc7feb5af7c9645f921aed8348a163acdb609416e40ad'
    end
    return JSON.parse(res.body)["url"] if res.status == 200
  end

  def consultation_params
    params.require(:consultation).permit(:start_time, :end_time, :status, :symptoms, :doctor_notes, :patient_notes, :total_price)
  end
end
