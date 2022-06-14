class CallsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "general"
  end

  def unsubscribed
  end
end
