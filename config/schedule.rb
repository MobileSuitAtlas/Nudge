# Use this file to easily define various to cron schedules.
# Unlike Rails' scheduler, Whenever doesn't require the Rails environment to be fully loaded.
# This helps if you want to run the scheduler in isolation.

# Set the environment
env = ENV.fetch("RAILS_ENV", "development")
set :environment, env

# Set the path where the whenever command will be run from
set :path, File.join(Dir.pwd, "bin/rails")

# Default to running every minute (for development - adjust for production)
every_1_minute = "* * * * *"
every_15_minutes = "*/15 * * * *"

# Run the nudge scheduler every 15 minutes
# In production, you might want to adjust this to every 5 minutes or so
every 15.minutes do
  rake "nudge:send_nudges"
end
