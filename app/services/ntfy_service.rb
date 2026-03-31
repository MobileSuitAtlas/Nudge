class NtfyService
    include HTTParty
    base_uri "https://ntfy.sh"

    def self.send_notification(message, options = {})
        topic = ENV.fetch("NTFY_TOPIC", "nudge_notification")

        post("/#{topic}",
            body: message,
            headers: {
                "title" => options[:title] || "Nudge Habit Builder",
                "tags" => options[:tags] || "bell",
            }
        )
    rescue HTTParty::Error => e
        Rails.logger.error "Ntfy notification failed: #{e.message}"
        false
    end
end