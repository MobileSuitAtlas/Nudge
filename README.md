# Nudge - A Gentle Habit Builder

> "A gentle habit tracker designed for people working on personal growth or those with anxiety."

Nudge helps build positive habits without pressure or negative reinforcement. It's designed to remind gently - not with loud alarms, but with kind messages like *"Hello! Have you done your reading for today?"*

The goal isn't to keep using the app forever. The best outcome? One day drop it, knowing a better habit has been built.

---

## Features

### Core Functionality
- **Habit Tracking** - Create habits with names, categories, and custom prompts
- **Daily Check-Ins** - Mark habits as complete for the day
- **Streak System** - Track consecutive days of completion (current & longest)
- **Focus Habit** - Set one habit as today's main focus 
- **Journal Entries** - Write thoughts, progress, and inspiration for each habit
- **Archive Habits** - Pause habits without deleting (keep all history!)
- **Colored Tags** - Organize habits with custom tags (Health, Fitness, Learning, etc.)

### Badge System
- **Achievement Badges** - Earn badges for hitting streak milestones
- **Available Badges:**
  - 🌱 Week Warrior (7 days)
  - 🔥 Fortnight Force (14 days)
  - ⚡ Three Week Thunder (21 days)
  - 🏆 Monthly Master (30 days)
  - 👑 Quarterly Quest (90 days)
  - 💎 Century Club (100 days)
  - 🌟 Year Champion (365 days)

### Encouragement System
- **Daily Nudges** - Toggle gentle noon reminders
- **Streak Messages** - Personalized messages based on streak length
- **Milestone Celebrations** - Special messages at 7, 14, 21, 28, and 30 days
- **Badge Rewards** - Earn visual badges for achievements
- **No Negative Reinforcement** - Only positive, supporting messages

### User
- **Dark Mode** - Toggle Preferences between light and dark themes
- **Data Export** - Download all habit data as CSV

### Categories
Choose from preset categories or create custom habits:
- 📚 Reading
- ✍️ Writing
- 💪 Workout
- 🎨 Drawing
- Custom (anything you want)

### Tags
Organize habits with colored tags:
- 🔴 Health (red)
- 🟢 Fitness (teal)
- 🔵 Learning (blue)
- 🟣 Creative (purple)
- 🟡 Productivity (yellow)
- 🩷 Mindfulness (pink)

---

## Tech Stack

| Technology | Purpose |
|------------|---------|
| **Ruby on Rails 8.1** | Web framework |
| **PostgreSQL** | Database |
| **Bootstrap 5** | Styling |
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
│   │   ├── habits_controller.rb       # All habit CRUD, check-ins, focus
│   │   ├── entries_controller.rb      # Journal entries
│   │   ├── tags_controller.rb         # Tag management
│   │   └── application_controller.rb # Base controller
│   ├── models/
│   │   ├── habit.rb                  # Habit logic, streaks, nudges
│   │   ├── check_in.rb               # Daily completion tracking
│   │   ├── entry.rb                  # Journal entries
│   │   ├── tag.rb                    # Colored tags
│   │   ├── badge.rb                  # Achievement badges
│   │   ├── earned_badge.rb           # Earned badges (join table)
│   │   └── application_record.rb     # Base model
│   ├── views/habits/
│   │   ├── index.html.erb            # List all habits
│   │   ├── edit.html.erb             # Edit habit form
│   │   ├── show.html.erb             # Habit details, stats, entries
│   │   └── new.html.erb              # Create new habit form
│   ├── helpers/
│   │   ├── habits_helper.rb          # Habit view helpers
│   │   └── application_helper.rb     # Base helpers
│   ├── mailers/
│   │   └── application_mailer.rb     # Base mailer
│   ├── jobs/
│   │   ├── application_job.rb        # Base job
│   │   └── send_nudge_job.rb         # Background nudge sending
│   └── javascript/controllers/       # Stimulus JS controllers
├── config/
│   ├── routes.rb                     # URL routes
│   ├── schedule.rb                   # Cron schedule for nudges
│   ├── application.rb                # Rails application config
│   ├── importmap.rb                  # JavaScript imports
│   └── puma.rb                       # Web server config
├── db/
│   ├── migrations/                   # Database migrations
│   ├── schema.rb                     # Database structure
│   └── seeds.rb                      # Sample data
├── lib/tasks/
│   └── nudge.rake                    # Nudge scheduler task
├── public/
│   ├── manifest.json                 # PWA manifest
│   ├── icon.png                      # App icon (PNG)
│   └── icon.svg                      # App icon (SVG)
├── test/                             # Test files
├── .github/workflows/                # CI/CD workflows
└── .kamal/                           # Kamal deployment config
```

---

## Routes

| URL | Method | Action | Description |
|-----|--------|--------|-------------|
| `/` | GET | index | Home - All habits with check-ins |
| `/habits` | GET | index | List all habits |
| `/habits/new` | GET | new | Create habit form |
| `/habits/:id/edit` | GET | edit | Edit habit form |
| `/habits` | POST | create | Create new habit |
| `/habits/:id` | GET | show | View habit details & entries |
| `/habits/:id` | PATCH | update | Update habit |
| `/habits/:id` | DELETE | destroy | Delete habit |
| `/habits/:id/check_in` | POST | check_in | Mark done for today |
| `/habits/:id/nudge` | POST | nudge | Get encouragement |
| `/habits/:id/set_focus` | POST | set_focus | Set today's focus |
| `/habits/:id/toggle_reminder` | POST | toggle_reminder | Enable/disable daily nudge |
| `/habits/:id/archive` | POST | archive | Archive a habit |
| `/habits/:id/unarchive` | POST | unarchive | Restore an archived habit |
| `/habits/reset_focus` | POST | reset_focus | Clear focus |
| `/habits/:id/entries` | POST | create | Add journal entry |
| `/habits/:id/entries/:id` | DELETE | destroy | Delete journal entry |
| `/tags` | GET | index | List all tags |
| `/tags` | POST | create | Create new tag |
| `/tags/:id` | PATCH | update | Update tag |
| `/tags/:id` | DELETE | destroy | Delete tag |
| `/toggle_theme` | POST | toggle_theme | Toggle dark/light mode |
| `/export` | GET | export | Download data as CSV |

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
| archived | boolean | Whether habit is archived |
| archived_at | datetime | When habit was archived |
| created_at | datetime | When habit was created |
| updated_at | datetime | Last update |

### tags table
| Column | Type | Description |
|--------|------|-------------|
| id | bigint | Primary key |
| name | string | Tag name (Health, Fitness, etc.) |
| color | string | Hex color code |
| created_at | datetime | When tag was created |
| updated_at | datetime | Last update |

### habit_tags table (join)
| Column | Type | Description |
|--------|------|-------------|
| id | bigint | Primary key |
| habit_id | bigint | Foreign key to habits |
| tag_id | bigint | Foreign key to tags |

### badges table
| Column | Type | Description |
|--------|------|-------------|
| id | bigint | Primary key |
| name | string | Badge name |
| icon | string | Emoji icon |
| description | text | Badge description |
| requirement_days | integer | Days needed to earn |
| created_at | datetime | When badge was created |
| updated_at | datetime | Last update |

### earned_badges table
| Column | Type | Description |
|--------|------|-------------|
| id | bigint | Primary key |
| habit_id | bigint | Foreign key to habits |
| badge_id | bigint | Foreign key to badges |
| earned_at | datetime | When badge was earned |
| created_at | datetime | When record was created |
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

## Tests

This project includes model tests for Habit validations and streak logic.

### Running Tests
```bash
rails test                 # Run all tests
rails test test/models/   # Run model tests only
rails test test/models/habit_test.rb  # Run specific file test
```

### Test Coverage
- **Habit Model** - Validations, streak calculations (current & longest), broken streak handling.
- **Entry Model** - Content presence, default date, association.
- **Tag Model** - Name uniqueness and presence, color presence.
- **Badge Model** - Name presence, requirement_days positive check.

---

## Development History

| Date | Change |
|------|--------|
| Feb 2, 2026 | Project started - basic habit CRUD |
| Feb 3-6, 2026 | Added controller, routes, title & description |
| Feb 7, 2026 | Added streak system |
| Feb 8, 2026 | Added encouragement messages, fixed bug with nested classes, added delete button |
| Feb 23, 2026 | Added category and prompt fields |
| Feb 26, 2026 | Fixed index page errors, added nudges, added Focus section to index with "Make Main Focus" button |
| Feb 27, 2026 | Added PWA manifest for mobile install, Journal Entries feature, and simple daily nudge (one button, noon default) |
| Feb 28, 2026 | Added Archive/Unarchive habits feature, Tags system with colored tags, Badge/Achievement system, Dark Mode toggle, and CSV Export feature |
| Mar 1, 2026 | Consolidated pages, fixed Dark Mode, fixed encouragement_message elsif bug, fixed badges association (has_many through), added edit view and controller action, added Habit model validations, added index on check_ins.date, added model tests for validations and streaks |
| Mar 2, 2026 | Added Entry, Tag, Badge model tests, added validations to Tag & Badge models |
---

## Future Ideas

-  **Push Notifications** - Web Push API integration for actual notifications
-  **Statistics** - Charts and progress visualization
-  **User Accounts** - Sync across devices
-  **Calendar View** - Visual calendar of completions
-  **Tags System** - Partially Implemented 
---

## License

MIT License - Feel free to use, modify, and share!

---

## Author

Built with 💜 by [MobileSuitAtlas](https://github.com/MobileSuitAtlas)

> "The best outcome is that one day you stop needing the app - because the habit has become part of your life."
