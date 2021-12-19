# frozen_string_literal: true

module Events
  class ConversationsAdded
    def self.perform(event)
      conversation = event.eventable
      app = conversation.app

      app.app_metrics.create(kind: 'opened_conversations')

      # AppIdentity.new(app.key)
      #           .opened_conversations
      #           .incr(1, Time.zone.now)

      EventTriggerProcessorJob.perform_later(
        id: conversation.app_id,
        event_id: event.id
      )
    end
  end
end
