class PracticeRelayJob < ApplicationJob
  queue_as :default

  def perform(parameters)
    # ActionCable.server.broadcast "practices",
    #   message: parameters[:code]
    #   head :ok
  end
end
