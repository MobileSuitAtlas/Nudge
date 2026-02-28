# Nudge - Gentle Habit Builder App

## What This App Does

**Nudge** is a gentle, anxiety-friendly habit tracker to build positive habits without negative reinforcement.

### Core Features:
- **Habit Tracking** - Create habits with names, descriptions, and categories
- **Daily Check-Ins** - Mark habits as complete for the day
- **Streak System** - Track consecutive days of completion (current & longest)
- **Focus Habit** - Set one habit as today's priority
- **Gentle Nudges** - Encouragement messages that motivate without guilt
- **Milestone Celebrations** - Special messages at 7, 14, 21, 28, and 30 days
- **Categories** - Reading, Writing, Workout, Drawing with emoji icons

### The Philosophy:
- No negative reinforcement for missed days
- Encouraging messages like "No problem, picking up new habits can be hard but keep trying!"
- Goal: Eventually drop the app once habit is built
- Designed for people with anxiety or those working on personal growth

---

## Project Structure

```
Nudge/
├── app/
│   ├── controllers/
│   │   └── habits_controller.rb    # All habit actions
│   ├── models/
│   │   ├── habit.rb               # Habit logic & streak calculations
│   │   └── check_in.rb            # Daily completion tracking
│   └── views/
│       └── habits/
│           ├── index.html.erb     # List all habits
│           ├── today.html.erb     # Today's view with check-ins
│           ├── show.html.erb      # Habit details & stats
│           └── new.html.erb       # Create new habit form
├── config/
│   └── routes.rb                  # URL routes
├── db/
│   ├── migrations/                # Database migrations
│   └── schema.rb                  # Database structure
└── public/
    └── icon.png                   # App icon
```

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

## Routes (URLs)

| URL | Method | Action | Purpose |
|-----|--------|--------|---------|
| `/` or `/today` | GET | today | Home - Today's habits with check-in buttons |
| `/habits` | GET | index | List all habits |
| `/habits/new` | GET | new | Create a new habit form |
| `/habits` | POST | create | Create new habit |
| `/habits/:id` | GET | show | View habit details and stats |
| POST `/habits/:id/check_in` | POST | check_in | Mark habit done for today |
| POST `/habits/:id/nudge` | POST | nudge | Get encouragement message |
| POST `/habits/:id/set_focus` | POST | set_focus | Set as today's focus habit |
| POST `/habits/reset_focus` | POST | reset_focus | Clear focus habit |

---

## Database Schema

### habits table
| Column | Type | Description |
|--------|------|-------------|
| id | bigint | Primary key |
| name | string | Habit name |
| description | text | Why you want this habit |
| category | string | Category (Reading, Writing, Workout, Drawing) |
| prompt | string | Custom reminder/prompt message |
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

## Key Code Concepts

### Habit Model (`app/models/habit.rb`)

**Streak Calculation:**
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

**Encouragement Messages** - Different messages based on streak:
- Day 0: "We start Today!"
- Day 1: "1 small step for man, 1 giant leap for new habits!"
- Day 3: "Day 3! I'm glad you are sticking with it!"
- Milestone (7 days): "One week is impressive, truly something to be proud of!"
- Milestone (30 days): "One month of pure consistency and dedication!"

**Categories with Emojis:**
- Reading → 📚
- Writing → ✍️
- Workout → 💪
- Drawing → 🎨

### Check-In System
- Each habit has many check_ins
- Check-ins store the `date` when completed
- A habit can only have one check-in per day (uses `find_or_create_by`)

---

## Running the App

```bash
cd Nudge
rails server
# Then open http://localhost:3000
```

---

## GitHub Repository

**URL:** https://github.com/MobileSuitAtlas/Nudge

The app is publicly hosted on GitHub with:
- Full README documentation
- All source code
- Docker configuration
- CI/CD workflows

---

## Conversation Summary

### Completed Fixes & Features:
1. **index.html.erb error** - Buttons referenced `@habit` (nil) instead of loop variable
   - Removed broken buttons outside the loop
   - Added "Start a New Habit" and "Need a Little Nudge?" buttons properly
2. **Created comprehensive README** - Full documentation with setup instructions, routes, schema, and development history
3. **Redesigned habit stats page** (`show.html.erb`)
   - Replaced plain list with Bootstrap card layout matching index design
   - Stats displayed as individual cards with better visual hierarchy
   - Added editable notes section with inline form (uses existing `update` action)
   - Added encouragement message alert box at top
   - Improved button styling (primary "Check In", outlined "Back to Habits")
4. **Added Check-In button to index page** 
   - "Check In" button (filled/primary) next to "View Details" button on habit list
   - Buttons side-by-side on desktop, stacked on mobile (< 576px)
   - Uses responsive CSS in `application.scss` for mobile layout

### Current State (as of Feb 26, 2026):
- App loads without errors ✓
- Index page shows habit list with "Check In" and "View Details" buttons ✓
- Index page has Focus section with "Make Main Focus" button ✓
- Today page has working check-in buttons ✓
- Show page has stats cards + editable notes section ✓
- Nudge system works with random encouragement messages ✓
- GitHub repository created and code pushed ✓
- Responsive design working on mobile/tablet/desktop ✓

### Known Issues to Fix:
- Missing edit form (`edit.html.erb`) - view page has "Edit Habits" link but no edit view exists
- No calendar/streak visualization yet

---

## Future Features (Planned)

### Phase 1: UI Improvements
- Calendar view showing check-in history
- Streak heatmap (like GitHub contributions)
- Better mobile responsiveness

### Phase 2: PWA Setup
- Make app installable on phones
- Enable push notifications (for gentle reminders)
- Service worker for offline support

### Phase 3: Reminder System (The "Hello!" Feature)
- Schedule specific times for reminders
- "Hello! Have you done your [habit] today?" messages
- Yes/No response flow that tracks completion
- No loud alarms - gentle browser notifications only

### Phase 4: User Accounts
- User authentication (signup/login)
- Sync data across devices
- Private/progress tracking

---

## My Vision

> "I wanted to make something that can be useful and even more so for people who have anxiety or battling something personal."
> 
> "Not like a loud alarm but something that will pop up on your phone going 'Hello! Have you done your reading for today?' if no 'No problem, picking up new habits can be hard but keep trying!' if yes 'Awesome! I'll go ahead and track that for you!'"
> 
> "It would be gentle in the sense that it wont have any negative reinforcement for not doing it but will be a gentle nudge."
> 
> "I hope that one day one that uses it will drop it or uninstall it knowing that they developed a better habit from it"

---

## Development Timeline

| Date | Change |
|------|--------|
| Feb 2, 2026 | Project started - basic habit CRUD |
| Feb 3-6, 2026 | Added controller, routes, title & description |
| Feb 7, 2026 | Added streak system |
| Feb 8, 2026 | Added encouragement messages, fixed nested class bug |
| Feb 8, 2026 | Added delete button |
| Feb 23, 2026 | Added category and prompt fields |
| Feb 26, 2026 | Fixed index page errors, added nudges |
| Feb 26, 2026 | Created comprehensive README, pushed to GitHub |
| Feb 26, 2026 | Redesigned stats page with card layout & editable notes section |
| Feb 26, 2026 | Added Check-In button to index page with responsive layout |
| Feb 26, 2026 | Added Focus section to index page with "Make Main Focus" button |

---

## Author

Built with 💜 by [MobileSuitAtlas](https://github.com/MobileSuitAtlas)
