# Nudge - A Gentle Habit Builder

> "A gentle habit tracker designed for people with anxiety or those working on personal growth."

Nudge helps you build positive habits without pressure or negative reinforcement. It's designed to remind you gently - not with loud alarms, but with kind messages like *"Hello! Have you done your reading for today?"*

The goal isn't to keep you using the app forever. The best outcome? One day you drop it, knowing you've built a better habit.

---

## Features

### Core Functionality
- **Habit Tracking** - Create habits with names, descriptions, and categories
- **Daily Check-Ins** - Mark habits as complete for the day
- **Streak System** - Track consecutive days of completion
- **Focus Habit** - Set one habit as today's main focus ⭐
- **Make Main Focus** - Set any habit as your priority directly from the habits list

### Encouragement System
- **Daily Nudges** - Get gentle reminders and encouragement
- **Streak Messages** - Personalized messages based on your streak
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
│   │   └── habits_controller.rb    # All habit actions
│   ├── models/
│   │   ├── habit.rb                 # Habit logic & streak calculations
│   │   └── check_in.rb              # Daily completion tracking
│   └── views/
│       └── habits/
│           ├── index.html.erb      # List all habits
│           ├── today.html.erb      # Today's view with check-ins
│           ├── show.html.erb       # Habit details & stats
│           └── new.html.erb        # Create new habit form
├── config/
│   └── routes.rb                   # URL routes
├── db/
│   ├── migrations/                 # Database migrations
│   └── schema.rb                  # Database structure
└── public/
    └── icon.png                    # App icon
```

---

## Routes

| URL | Method | Action | Description |
|-----|--------|--------|-------------|
| `/` | GET | today | Home - Today's habits |
| `/habits` | GET | index | List all habits |
| `/habits/new` | GET | new | Create habit form |
| `/habits` | POST | create | Create new habit |
| `/habits/:id` | GET | show | View habit details |
| `/habits/:id/check_in` | POST | check_in | Mark done for today |
| `/habits/:id/nudge` | POST | nudge | Get encouragement |
| `/habits/:id/set_focus` | POST | set_focus | Set today's focus |
| `/habits/reset_focus` | POST | reset_focus | Clear focus |

---

## Database Schema

### habits table
| Column | Type | Description |
|--------|------|-------------|
| id | bigint | Primary key |
| name | string | Habit name |
| description | text | Why you want this habit |
| category | string | Category (Reading, Writing, etc.) |
| prompt | string | Custom reminder message |
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

---

## Future Ideas

- 📅 **Calendar View** - Visual calendar showing check-in history
- 🔔 **Push Notifications** - Gentle browser reminders
- 📱 **PWA Support** - Installable on mobile devices
- 📊 **Statistics** - Charts and progress visualization
- 👥 **User Accounts** - Sync across devices

---

## License

MIT License - Feel free to use, modify, and share!

---

## Author

Built with 💜 by [MobileSuitAtlas](https://github.com/MobileSuitAtlas)

> "The best outcome is that one day you stop needing the app - because the habit has become part of your life."
