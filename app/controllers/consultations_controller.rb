require 'faraday'
require 'faraday/net_http'
Faraday.default_adapter = :net_http

class ConsultationsController < ApplicationController

  def show
    @consultation = Consultation.find(params[:id])
    @doctor = @consultation.doctor
    @patient = @consultation.patient
    #check what is @consultation.room_url for empty room
    if @consultation.room_url.present?
      @room_url = @consultation.room_url
    else
      res = Faraday.post "https://api.daily.co/v1/rooms/" do |req|
        req.body = { properties: { enable_chat: true, enable_people_ui: false, enable_pip_ui: true }}.to_json
        req.headers['Content-Type'] = 'application/json'
        req.headers['Authorization'] = 'Bearer 805ef46e7bdb8a21f60dc7feb5af7c9645f921aed8348a163acdb609416e40ad'
      end
      # raise
      @consultation.room_url = JSON.parse(res.body)["url"] if res.status == 200
      @consultation.save!
      @room_url = @consultation.room_url
    end
  end

  def create
    @doctor = User.find(params[:doctor_id])
    @consultation =  Consultation.new()
    @consultation.doctor = @doctor
    @consultation.patient = current_user
    @consultation.status = 'calling'
    if @consultation.save
      ActionCable.server.broadcast("general", { doctor_id: @doctor.id, consultation_id: @consultation.id }) # @consultation.id Notify Doctor of the new Call/consultation
      @doctor.status = "Busy"
      @doctor.save

      redirect_to consultation_path(@consultation)
    else
     render 'doctors/show'
    end
  end

  def update
    @consultation = Consultation.find(params[:id])
    @consultation.update(consultation_params)
  end

  private

  def consultation_params
    params.require(:consultation).permit(:start_time, :end_time, :status, :symptoms)
  end

end
