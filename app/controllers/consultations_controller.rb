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
        req.body = URI.encode_www_form({})
        req.headers['Content-Type'] = 'application/json'
        req.headers['Authorization'] = 'Bearer 805ef46e7bdb8a21f60dc7feb5af7c9645f921aed8348a163acdb609416e40ad'
      end
      @consultation.room_url = JSON.parse(res.body)["url"] if res.status == 200
      @consultation.save!
      @room_url = @consultation.room_url
    end
  end
end