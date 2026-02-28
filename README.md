# Nudge - A Gentle Habit Builder

> "A gentle habit tracker designed for people with anxiety or those working on personal growth."

Nudge helps build positive habits without pressure or negative reinforcement. It's designed to remind gently - not with loud alarms, but with kind messages like *"Hello! Have you done your reading for today?"*

The goal isn't to keep using the app forever. The best outcome? One day drop it, knowing a better habit has been built.

---

## Features

### Core Functionality
- **Habit Tracking** - Create habits with names, categories, and custom prompts
- **Daily Check-Ins** - Mark habits as complete for the day
- **Streak System** - Track consecutive days of completion (current & longest)
- **Focus Habit** - Set one habit as today's main focus ⭐
- **Journal Entries** - Write thoughts, progress, and inspiration for each habit

### Encouragement System
- **Daily Nudges** - Toggle gentle noon reminders
- **Streak Messages** - Personalized messages based on streak length
- **Milestone Celebrations** - Special messages at 7, 14, 21, 28, and 30 days
- **No Negative Reinforcement** - Only positive, supporting messages

### Categories
Choose from preset categories or create custom habits:
- 📚 Reading
- ✍️ Writing
- 💪 Workout
- 🎨 Drawing
- Custom (anything you want!)

---

## Tech Stack

| Technology | Purpose |
|------------|---------|
| **Ruby on Rails 8.1** | Web framework |
| **PostgreSQL** | Database |
| **Bootstrap 5** | Styling & responsive design |
| **Turbo** | Fast page updates |
| **Stimulus** | Interactive JavaScript |
| **Whenever** | Cron scheduling for nudges |
| **Puma** | Web server |
| **Docker** | Container deployment |

---

## Getting Started

### Prerequisites
- Ruby 3.x
- Rails 8.x
- PostgreSQL
- Node.js (for JavaScript)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/MobileSuitAtlas/Nudge.git
   cd Nudge
   ```

2. **Install dependencies**
   ```bash
   bundle install
   npm install
   ```

3. **Set up the database**
   ```bash
   rails db:create db:migrate
   ```

4. **Start the server**
   ```bash
   rails server
   ```

5. **Open your browser**
   ```
   http://localhost:3000
   ```

---

## Project Structure

```
Nudge/
├── app/
│   ├── controllers/
│   │   ├── habits_controller.rb       # All habit actions
│   │   └── entries_controller.rb     # Journal entries
│   ├── models/
│   │   ├── habit.rb                   # Habit logic, streaks, nudges
│   │   ├── check_in.rb                # Daily completion tracking
│   │   └── entry.rb                   # Journal entries
│   ├── views/
│   │   └── habits/
│   │       ├── index.html.erb         # List all habits
│   │       ├── today.html.erb         # Today's view with check-ins
│   │       ├── show.html.erb          # Habit details, stats, entries
│   │       └── new.html.erb           # Create new habit form
│   └── javascript/
│       └── nudge_app.js               # Notification handling
├── config/
│   ├── routes.rb                      # URL routes
│   └── schedule.rb                    # Cron schedule for nudges
├── db/
│   ├── migrations/                    # Database migrations
│   └── schema.rb                      # Database structure
├── lib/tasks/
│   └── nudge.rake                     # Nudge scheduler task
└── public/
    ├── manifest.json                  # PWA manifest
    └── icon.png                      # App icon
```

---

## Routes

| URL | Method | Action | Description |
|-----|--------|--------|-------------|
| `/` or `/today` | GET | today | Home - Today's habits |
| `/habits` | GET | index | List all habits |
| `/habits/new` | GET | new | Create habit form |
| `/habits` | POST | create | Create new habit |
| `/habits/:id` | GET | show | View habit details & entries |
| `/habits/:id/check_in` | POST | check_in | Mark done for today |
| `/habits/:id/nudge` | POST | nudge | Get encouragement |
| `/habits/:id/set_focus` | POST | set_focus | Set today's focus |
| `/habits/:id/toggle_reminder` | POST | toggle_reminder | Enable/disable daily nudge |
| `/habits/reset_focus` | POST | reset_focus | Clear focus |
| `/habits/:id/entries` | POST | create | Add journal entry |
| `/habits/:id/entries/:id` | DELETE | destroy | Delete journal entry |

---

## Database Schema

### habits table
| Column | Type | Description |
|--------|------|-------------|
| id | bigint | Primary key |
| name | string | Habit name |
| category | string | Category (Reading, Writing, etc.) |
| prompt | string | Custom reminder message |
| reminder_time | time | Time for daily nudge (default: 12:00 PM) |
| reminders_enabled | boolean | Whether nudges are enabled |
| created_at | datetime | When habit was created |
| updated_at | datetime | Last update |

### check_ins table
| Column | Type | Description |
|--------|------|-------------|
| id | bigint | Primary key |
| habit_id | bigint | Foreign key to habits |
| date | date | The day checked in |
| created_at | datetime | When check-in was created |
| updated_at | datetime | Last update |

### entries table
| Column | Type | Description |
|--------|------|-------------|
| id | bigint | Primary key |
| habit_id | bigint | Foreign key to habits |
| content | text | Journal entry text |
| entry_date | date | The date the entry is about |
| created_at | datetime | When entry was created |
| updated_at | datetime | Last update |

---

## Key Code

### Streak Calculation (`app/models/habit.rb`)
```ruby
def current_streak
  streak = 0
  day = Date.today
  
  while check_ins.exists?(date: day)
    streak += 1
    day -= 1
  end
  streak
end
```

### Encouragement Messages
The app provides different messages based on streak length:
- Day 0: "We start Today!"
- Day 1: "1 small step for man, 1 giant leap for new habits!"
- Day 3: "Day 3! I'm glad you are sticking with it!"
- Milestone (7 days): "One week is impressive, truly something to be proud of!"
- Milestone (30 days): "One month of pure consistency and dedication!"

### Daily Nudge
The daily nudge system allows enabling/disabling noon reminders for each habit. When enabled, a gentle notification appears if the habit hasn't been checked in for the day.

---

## Development History

| Date | Change |
|------|--------|
| Feb 2, 2026 | Project started - basic habit CRUD |
| Feb 3-6, 2026 | Added controller, routes, title & description |
| Feb 7, 2026 | Added streak system |
| Feb 8, 2026 | Added encouragement messages, fixed bug with nested classes |
| Feb 8, 2026 | Added delete button |
| Feb 23, 2026 | Added category and prompt fields |
| Feb 26, 2026 | Fixed index page errors, added nudges |
| Feb 26, 2026 | Added Focus section to index with "Make Main Focus" button |
| Feb 27, 2026 | Added PWA manifest for mobile install |
| Feb 27, 2026 | Added Journal Entries feature |
| Feb 27, 2026 | Added simple daily nudge (one button, noon default) |

---

## Future Ideas

- 🔔 **Push Notifications** - Web Push API integration for actual notifications
- 📊 **Statistics** - Charts and progress visualization
- 👥 **User Accounts** - Sync across devices

---

## License

MIT License - Feel free to use, modify, and share!

---

## Author

Built with 💜 by [MobileSuitAtlas](https://github.com/MobileSuitAtlas)

> "The best outcome is that one day you stop needing the app - because the habit has become part of your life."
